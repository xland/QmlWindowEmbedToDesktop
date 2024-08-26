#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
#include <qquickwindow.h>
#include <qwindow.h>
#include <EmbedHelper.h>
#include <qquickitem.h>

//windeployqt QmlWindowEmbedToDesktop.exe  -qmldir  D:\tool\FUCK\6.7.1\msvc2019\qml

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/qmlwindowembedtodesktop/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    auto winObj = engine.rootObjects().at(0);
    auto instance = EmbedHelper::Init(winObj);
    engine.rootContext()->setContextProperty("embedHelper", instance);
    return app.exec();
}
