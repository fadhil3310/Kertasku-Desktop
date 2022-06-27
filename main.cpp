#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "lib/mica/mica.h"
#include <QObject>
#include <QIcon>
#include <QQuickStyle>



int main(int argc, char *argv[])
{


#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //QQuickWindow::setSceneGraphBackend(QSGRendererInterface::Software);
#else
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);
#endif
    QGuiApplication app(argc, argv);
        qDebug() << QQuickStyle::name();
    QQuickWindow::setTextRenderType(QQuickWindow::NativeTextRendering);
    //QIcon::setThemeSearchPaths(QStringList(":/Fluent/icon"));

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/");
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    // From https://forum.qt.io/topic/92952/how-to-get-window-handle-while-i-use-qml
    QQuickWindow *window = qobject_cast<QQuickWindow*>(engine.rootObjects().at(0));
    MicaMaterial::enableForWindow(HWND(window->winId()));

    return app.exec();
}
