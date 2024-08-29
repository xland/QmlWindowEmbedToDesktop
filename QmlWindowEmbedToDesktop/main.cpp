#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <EmbedHelper.h>
#include <qqmlcontext.h>
#include <qquickitem.h>

// D:/tool/FUCK/6.7.1/msvc2019_64/bin/windeployqt --release --compiler-runtime --core --gui --network --widgets --no-svg --no-translations QmlWindowEmbedToDesktop.exe  -qmldir  D:\tool\FUCK\6.7.1\msvc2019_64\qml
int main(int argc, char* argv[])
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
