#include "EmbedHelper.h"

#include <hidusage.h>
#include <cstdint>

namespace {
	HWND workerW = nullptr;
	HWND rawInputWindowHandle = nullptr;
	HWND tarHwnd = nullptr;
    bool isEmbeded = false;
}
LRESULT CALLBACK handleWindowMessage(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    if (uMsg == WM_INPUT && isEmbeded)
    {
        UINT dwSize = sizeof(RAWINPUT);
        static BYTE lpb[sizeof(RAWINPUT)];
        GetRawInputData((HRAWINPUT)lParam, RID_INPUT, lpb, &dwSize, sizeof(RAWINPUTHEADER));
        auto* raw = (RAWINPUT*)lpb;
        switch (raw->header.dwType)
        {
        case RIM_TYPEMOUSE:
        {
            RAWMOUSE rawMouse = raw->data.mouse;
            if ((rawMouse.usButtonFlags & RI_MOUSE_WHEEL) == RI_MOUSE_WHEEL || (rawMouse.usButtonFlags & RI_MOUSE_HWHEEL) == RI_MOUSE_HWHEEL)
            {
                bool isHorizontalScroll = (rawMouse.usButtonFlags & RI_MOUSE_HWHEEL) == RI_MOUSE_HWHEEL;
                auto wheelDelta = (float)(short)rawMouse.usButtonData;
                if (isHorizontalScroll)
                {
                    PostMessage(tarHwnd, WM_HSCROLL, wheelDelta > 0 ? SB_LINELEFT : SB_LINERIGHT, 0);
                }
                else
                {
                    PostMessage(tarHwnd, WM_VSCROLL, wheelDelta > 0 ? SB_LINEUP : SB_LINEDOWN, 0);
                }
                break;
            }
            POINT point;
            GetCursorPos(&point);
            ScreenToClient(tarHwnd, &point);
            auto lParam = MAKELPARAM(point.x, point.y);
            switch (rawMouse.ulButtons)
            {
            case RI_MOUSE_LEFT_BUTTON_DOWN:
            {
                PostMessage(tarHwnd, WM_LBUTTONDOWN, MK_LBUTTON, lParam);
                break;
            }
            case RI_MOUSE_LEFT_BUTTON_UP:
            {
                PostMessage(tarHwnd, WM_LBUTTONUP, MK_LBUTTON, lParam);
                break;
            }
            case RI_MOUSE_RIGHT_BUTTON_DOWN:
            {
                PostMessage(tarHwnd, WM_RBUTTONDOWN, MK_RBUTTON, lParam);
                break;
            }
            case RI_MOUSE_RIGHT_BUTTON_UP:
            {
                PostMessage(tarHwnd, WM_RBUTTONUP, MK_RBUTTON, lParam);
                break;
            }
            default:
            {
                PostMessage(tarHwnd, WM_MOUSEMOVE, 0x0020, lParam);
                break;
            }
            }
            break;
        }
        case RIM_TYPEKEYBOARD:
        {
            auto message = raw->data.keyboard.Message;
            auto vKey = raw->data.keyboard.VKey;
            auto makeCode = raw->data.keyboard.MakeCode;
            auto flags = raw->data.keyboard.Flags;
            std::uint32_t lParam = 1u;
            lParam |= static_cast<std::uint32_t>(makeCode) << 16;
            lParam |= 1u << 24;
            lParam |= 0u << 29;
            if (!(flags & RI_KEY_BREAK)) {
                lParam |= 1u << 30;
                lParam |= 1u << 31;
            }
            PostMessage(tarHwnd, message, vKey, lParam);
            break;
        }
        }
    }
    return DefWindowProc(hWnd, uMsg, wParam, lParam);
}
void roteInput()
{
    if (rawInputWindowHandle != nullptr)
    {
        return;
    }
    HINSTANCE hInstance = GetModuleHandle(nullptr);
    WNDCLASS wc = {};
    wc.lpfnWndProc = handleWindowMessage;
    wc.hInstance = hInstance;
    wc.lpszClassName = L"HikRawInputWindow";
    if (!RegisterClass(&wc))
    {
        return;
    }
    rawInputWindowHandle = CreateWindowEx(0, wc.lpszClassName, nullptr, 0, 0, 0, 0, 0, HWND_MESSAGE, nullptr, hInstance, nullptr);
    if (!rawInputWindowHandle)
    {
        return;
    }
    RAWINPUTDEVICE rids[2];
    rids[0].usUsagePage = HID_USAGE_PAGE_GENERIC;
    rids[0].usUsage = HID_USAGE_GENERIC_MOUSE;
    rids[0].dwFlags = RIDEV_INPUTSINK;
    rids[0].hwndTarget = rawInputWindowHandle;

    rids[1].usUsagePage = HID_USAGE_PAGE_GENERIC;
    rids[1].usUsage = HID_USAGE_GENERIC_KEYBOARD;
    rids[1].dwFlags = RIDEV_EXINPUTSINK;
    rids[1].hwndTarget = rawInputWindowHandle;
    RegisterRawInputDevices(rids, 2, sizeof(rids[0]));
}


EmbedHelper::~EmbedHelper()
{
}
void EmbedHelper::SetHwnd(HWND _tarHwnd) {
    tarHwnd = _tarHwnd;
}
void EmbedHelper::Embed() { 
    if (!workerW) {
        auto hwnd = GetShellWindow();
        SendMessage(hwnd, 0x052C, 0x0000000D, 0);
        SendMessage(hwnd, 0x052C, 0x0000000D, 1);
        EnumWindows([](HWND topHandle, LPARAM topParamHandle) {
            HWND shellDllDefView = FindWindowEx(topHandle, nullptr, L"SHELLDLL_DefView", nullptr);
            if (shellDllDefView != nullptr) {
                workerW = FindWindowEx(nullptr, topHandle, L"WorkerW", nullptr);
            }
            return TRUE;
            }, NULL);
    }
    SetParent(tarHwnd, workerW);
    roteInput();
    isEmbeded = true;
}
void EmbedHelper::UnEmbed()
{
    //SendMessage(rawInputWindowHandle, WM_CLOSE, 0, 0);
    //RAWINPUTDEVICE rids[2];
    //rids[0].usUsagePage = HID_USAGE_PAGE_GENERIC;
    //rids[0].usUsage = HID_USAGE_GENERIC_MOUSE;
    //rids[0].dwFlags = RIDEV_INPUTSINK;
    //rids[0].hwndTarget = nullptr;

    //rids[1].usUsagePage = HID_USAGE_PAGE_GENERIC;
    //rids[1].usUsage = HID_USAGE_GENERIC_KEYBOARD;
    //rids[1].dwFlags = RIDEV_EXINPUTSINK;
    //rids[1].hwndTarget = nullptr;
    //RegisterRawInputDevices(rids, 2, sizeof(rids[0]));
    //rawInputWindowHandle = nullptr;
    SetParent(tarHwnd, nullptr);
    isEmbeded = false;
}
