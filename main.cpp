#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
//#include "lib/mica/mica.h"
#include <QObject>
#include <QOperatingSystemVersion>
#include <QScopedPointer>
#include <QQuickStyle>
#include <QTranslator>
#include <QLocale>
#include <QPalette>
#include <QFontDatabase>

#include "notemanager.h"
#include "booklistmodel.h"



int main(int argc, char *argv[]) {


#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QQuickStyle::setStyle(":/lib/modules/Fluent");
    //QQuickWindow::setSceneGraphBackend(QSGRendererInterface::Software);
#else
    QQuickStyle::setStyle("Fluent");
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);
#endif
    QCoreApplication::setOrganizationName("siapawehee");
    QCoreApplication::setApplicationName("Kertasku");

    QGuiApplication app(argc, argv);
    QQuickWindow::setTextRenderType(QQuickWindow::NativeTextRendering);

    QFontDatabase::addApplicationFont(":/asset/font/Cairo-Regular.ttf");
    QFontDatabase::addApplicationFont(":/asset/font/Cairo-Bold.ttf");
    QFontDatabase::addApplicationFont(":/asset/font/Cairo-Light.ttf");

    QQmlApplicationEngine engine;

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    // Modules only for Qt 5
    engine.addImportPath("qrc:/lib/modules-qt5");
#else
    // Modules only for Qt 6
    engine.addImportPath("qrc:/lib/modules-qt6");
#endif
    engine.addImportPath("qrc:/lib/modules"); // Modules for both Qt 5 and 6
    engine.addImportPath("qrc:/qml");

    QString path;
    foreach (path, engine.importPathList()) {
        qDebug() << path;
    }

    /*QTranslator translator;
    translator.load(":/translation/lang_id.qm");
    app.installTranslator(&translator);
    qDebug() << translator.language();*/

    qmlRegisterType<NoteManager>("Kertasku", 1, 0, "NoteBackend");

    /*QPalette palette = QGuiApplication::palette();
    palette.setBrush(QPalette::Text, Qt::red);
    palette.setBrush(QPalette::WindowText, Qt::red);
    palette.setBrush(QPalette::ButtonText, Qt::red);
    palette.setBrush(QPalette::BrightText, Qt::red);
    palette.setBrush(QPalette::Window, Qt::red);
    QGuiApplication::setPalette(palette);*/

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
