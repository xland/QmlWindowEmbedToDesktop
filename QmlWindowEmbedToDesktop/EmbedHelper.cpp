#include "EmbedHelper.h"
#include <Windows.h> 
#include <hidusage.h>

namespace {
	HWND workerW = nullptr;
	HWND rawInputWindowHandle = nullptr;
	HWND windowHwnd = nullptr;
}

void embed(HWND tarHwnd) {
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
    SetParent(tarHwnd, workerW);
}

LRESULT CALLBACK handleWindowMessage(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    if (uMsg == WM_INPUT)
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
                    PostMessage(windowHwnd, WM_HSCROLL, wheelDelta > 0 ? SB_LINELEFT : SB_LINERIGHT, 0);
                }
                else
                {
                    PostMessage(windowHwnd, WM_VSCROLL, wheelDelta > 0 ? SB_LINEUP : SB_LINEDOWN, 0);
                }
                break;
            }
            POINT point;
            GetCursorPos(&point);
            ScreenToClient(windowHwnd, &point);
            auto lParam = MAKELPARAM(point.x, point.y);
            switch (rawMouse.ulButtons)
            {
            case RI_MOUSE_LEFT_BUTTON_DOWN:
            {
                PostMessage(windowHwnd, WM_LBUTTONDOWN, MK_LBUTTON, lParam);
                break;
            }
            case RI_MOUSE_LEFT_BUTTON_UP:
            {
                PostMessage(windowHwnd, WM_LBUTTONUP, MK_LBUTTON, lParam);
                break;
            }
            case RI_MOUSE_RIGHT_BUTTON_DOWN:
            {
                PostMessage(windowHwnd, WM_RBUTTONDOWN, MK_RBUTTON, lParam);
                break;
            }
            case RI_MOUSE_RIGHT_BUTTON_UP:
            {
                PostMessage(windowHwnd, WM_RBUTTONUP, MK_RBUTTON, lParam);
                break;
            }
            default:
            {
                PostMessage(windowHwnd, WM_MOUSEMOVE, 0x0020, lParam);
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
            PostMessage(windowHwnd, message, vKey, lParam);
            break;
        }
        }
    }
    return DefWindowProc(hWnd, uMsg, wParam, lParam);
}

void startForwardingRawInput()
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


EmbedHelper::EmbedHelper()
{
}

EmbedHelper::~EmbedHelper()
{
}