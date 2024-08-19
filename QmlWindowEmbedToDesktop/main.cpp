#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qquickwindow.h>
#include <qwindow.h>
#include <EmbedHelper.h>


int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN) && QT_VERSION_CHECK(5, 6, 0) <= QT_VERSION && QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/qmlwindowembedtodesktop/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    auto winObj = engine.rootObjects().at(0);
    QQuickWindow* window = static_cast<QQuickWindow*>(winObj);
    auto hwnd = (HWND)window->winId();
    //EmbedHelper::Embed(hwnd);
    return app.exec();
}
