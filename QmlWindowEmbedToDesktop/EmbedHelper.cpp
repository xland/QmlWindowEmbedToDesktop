#include "EmbedHelper.h"
#include <hidusage.h>
#include <cstdint>
#include <qquickitem.h>
#include <format>
#include <iostream>
#include <qcoreapplication.h>
#include <qscreen.h>
#include <QScreen>

namespace {
	HWND workerW{ nullptr };
    HWND shellHwnd{ nullptr };
    HWND desktopHwnd{ nullptr };
	HWND tarHwnd{ nullptr };
    HWND sysListView32HWND{ nullptr };
    bool isEmbeded{ false };
    std::vector<wchar_t> buf(18);
    QQuickWindow* window;
    WNDPROC OldProc;
    RECT tarRect;
    EmbedHelper* instance;
    qreal scaleFactor;
}

std::wstring GetWindowClassName(HWND hwnd)
{
    std::array<WCHAR, 16> className;
    GetClassName(hwnd, className.data(), (int)className.size());
    std::wstring title(className.data());
    return title;
}

void LogMessage(const std::string&& message) {
    OutputDebugStringA(message.c_str());
    OutputDebugStringA("\r\n");
}

POINT getMousePosInWin() {
    POINT point;
    GetCursorPos(&point);
    if (point.x > tarRect.left && point.y > tarRect.top && point.x < tarRect.right && point.y < tarRect.bottom) {
        point.x = point.x - tarRect.left;
        point.y = point.y - tarRect.top;
    }
    else
    {
        point.x = -100;
        point.y = -100;
    }
    return point;
}

void sendEvent(QObject* parent, QMouseEvent* event) {
    for (QObject* child : parent->children()) {
        QQuickItem* childItem = qobject_cast<QQuickItem*>(child);
        if (childItem) {
            QCoreApplication::postEvent(childItem, event);
            sendEvent(childItem, event);
        }
    }
}

LRESULT CALLBACK handleWindowMessage(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    if (uMsg == WM_INPUT && isEmbeded)
    {
        POINT point = getMousePosInWin();
        if (point.x < 0 && point.y < 0 && isEmbeded) {
            return 0;
        }
        HWND curHwnd = WindowFromPoint(point);
        auto cn = GetWindowClassName(curHwnd);
        if (cn != L"SysListView32") {
            return 0;
        }
        auto ratio = window->screen()->devicePixelRatio();
        UINT dwSize = sizeof(RAWINPUT);
        static BYTE lpb[sizeof(RAWINPUT)];
        GetRawInputData((HRAWINPUT)lParam, RID_INPUT, lpb, &dwSize, sizeof(RAWINPUTHEADER));
        auto* raw = (RAWINPUT*)lpb;
        switch (raw->header.dwType)
        {
            case RIM_TYPEMOUSE:
            {
                RAWMOUSE rawMouse = raw->data.mouse;
                if (rawMouse.usButtonFlags == RI_MOUSE_WHEEL)
                {
                    point.x = point.x / ratio;
                    point.y = point.y / ratio;
                    auto wheelDelta = (float)(short)rawMouse.usButtonData; 
                    QMetaObject::invokeMethod(window, "wheelFunc", Q_ARG(QVariant, wheelDelta > 0), Q_ARG(QVariant, (int)point.x), Q_ARG(QVariant, (int)point.y));
                    break;
                }
                auto lParam = MAKELPARAM(point.x, point.y);
                switch (rawMouse.ulButtons)
                {
                    case RI_MOUSE_LEFT_BUTTON_DOWN:
                    {
                        PostMessage(tarHwnd, WM_LBUTTONDOWN, MK_LBUTTON, lParam);
                        point.x = point.x / ratio;
                        point.y = point.y / ratio;
                        QMetaObject::invokeMethod(window, "downFunc", Q_ARG(QVariant, (int)point.x), Q_ARG(QVariant, (int)point.y));
                        break;
                    }
                    case RI_MOUSE_LEFT_BUTTON_UP:
                    {
                        PostMessage(tarHwnd, WM_LBUTTONUP, MK_LBUTTON, lParam);
                        point.x = point.x / ratio;
                        point.y = point.y / ratio;
                        QMetaObject::invokeMethod(window, "upFunc", Q_ARG(QVariant, (int)point.x), Q_ARG(QVariant, (int)point.y));
                        break;
                    }
                    default:
                    {
                        point.x = point.x / ratio;
                        point.y = point.y / ratio;
                        QMetaObject::invokeMethod(window, "moveFunc", Q_ARG(QVariant, (int)point.x), Q_ARG(QVariant, (int)point.y));
                        return 0;
                    }
                }
                break;
            }
        }
    }
    return CallWindowProc(OldProc, hWnd, uMsg, wParam, lParam);
}
void roteInput()
{
    RAWINPUTDEVICE rids[2];
    rids[0].usUsagePage = HID_USAGE_PAGE_GENERIC;
    rids[0].usUsage = HID_USAGE_GENERIC_MOUSE;
    rids[0].dwFlags = RIDEV_INPUTSINK;
    rids[0].hwndTarget = tarHwnd;

    rids[1].usUsagePage = HID_USAGE_PAGE_GENERIC;
    rids[1].usUsage = HID_USAGE_GENERIC_KEYBOARD;
    rids[1].dwFlags = RIDEV_EXINPUTSINK;
    rids[1].hwndTarget = tarHwnd;
    RegisterRawInputDevices(rids, 2, sizeof(rids[0]));
    OldProc = (WNDPROC)SetWindowLongPtr(tarHwnd, GWLP_WNDPROC, (LONG_PTR)handleWindowMessage);
}


EmbedHelper::~EmbedHelper()
{
}

EmbedHelper* EmbedHelper::Init(QObject* _root) {
    window = static_cast<QQuickWindow*>(_root);
    tarHwnd = (HWND)window->winId();
    instance = new EmbedHelper(_root);
    return instance;
}

void EmbedHelper::Embed() { 
    if (isEmbeded) {
        SetWindowLongPtr(tarHwnd, GWLP_WNDPROC, (LONG_PTR)OldProc);
        SetParent(tarHwnd, nullptr);
        isEmbeded = false;
    }
    else {
        if (!workerW) {
            desktopHwnd = GetDesktopWindow();
            shellHwnd = GetShellWindow();
            SendMessage(shellHwnd, 0x052C, 0x0000000D, 0);
            SendMessage(shellHwnd, 0x052C, 0x0000000D, 1);
            EnumWindows([](HWND topHandle, LPARAM topParamHandle) {
                HWND shellDllDefView = FindWindowEx(topHandle, nullptr, L"SHELLDLL_DefView", nullptr);
                if (shellDllDefView != nullptr) {
                    workerW = FindWindowEx(nullptr, topHandle, L"WorkerW", nullptr);
                    sysListView32HWND = FindWindowEx(shellDllDefView, NULL, L"SysListView32", NULL);
                }
                return TRUE;
                }, NULL);
        }
        SetParent(tarHwnd, workerW);
        //roteInput();
        //GetWindowRect(tarHwnd, &tarRect);

        DWORD workerWThreadId = GetWindowThreadProcessId(sysListView32HWND, nullptr);
        DWORD targetThreadId = GetWindowThreadProcessId(tarHwnd, nullptr);
        auto flag = AttachThreadInput(workerWThreadId, targetThreadId, TRUE);
        SetForegroundWindow(tarHwnd);
        SetFocus(tarHwnd);


        isEmbeded = true;
    }
}
void EmbedHelper::WinResized()
{
    GetWindowRect(tarHwnd, &tarRect);
}
