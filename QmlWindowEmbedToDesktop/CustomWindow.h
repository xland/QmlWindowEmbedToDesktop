#pragma once

#include <QWindow>
#include <Windows.h>

class CustomWindow : public QWindow {
    Q_OBJECT
public:
    CustomWindow(QWindow* parent = nullptr) : QWindow(parent) {
        setFlags(Qt::Window | Qt::FramelessWindowHint);
    }
protected:
    bool nativeEvent(const QByteArray& eventType, void* message, qintptr* result) override {
        MSG* msg = static_cast<MSG*>(message);
        if (eventType == "windows_generic_MSG") {
            if (msg->message == WM_SYSCOMMAND && (msg->wParam & 0xfff0) == SC_MINIMIZE) {
                showNormal();
                return true;
            }
        }
        return QWindow::nativeEvent(eventType, message, result);
    }
};
