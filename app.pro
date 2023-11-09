QT += quick quickcontrols2

greaterThan(QT_MAJOR_VERSION, 5) {
    QT += core5compat
    RESOURCES += \
        qt6.qrc

    QML_IMPORT_PATH += $$PWD/lib/modules-qt6

    win32 {
        LIBS += -L$$PWD/'../../../../../../Program Files (x86)/QuaZip/lib/' -llibquazip1-qt6.dll

        INCLUDEPATH += $$PWD/'../../../../../../Program Files (x86)/QuaZip/include/QuaZip-Qt6-1.3'
        DEPENDPATH += $$PWD/'../../../../../../Program Files (x86)/QuaZip/include/QuaZip-Qt6-1.3'
    }
}
lessThan(QT_MAJOR_VERSION, 6) {
    RESOURCES += \
    qt5.qrc

    QML_IMPORT_PATH += $$PWD/lib/modules-qt5

    win32 {
        LIBS += -L$$PWD/'../../../../../../Program Files (x86)/QuaZip/lib/' -llibquazip1-qt5.dll

        INCLUDEPATH += $$PWD/'../../../../../../Program Files (x86)/QuaZip/include/QuaZip-Qt5-1.3'
        DEPENDPATH += $$PWD/'../../../../../../Program Files (x86)/QuaZip/include/QuaZip-Qt5-1.3'
    }
}

DESTDIR = ./

#win32:LIBS += $$PWD/lib/QuaZip/bin/libquazip1-qt6.dll
#INCLUDEPATH += $$PWD/lib/QuaZip/include/QuaZip-Qt6-1.3
#DEPENDPATH += $$PWD/lib/QuaZip/include/QuaZip-Qt6-1.3


# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        #lib/mica/mica.cpp \
        #lib/modules/Fluent/fluentdesign.cpp \
        #lib/ostheme/ostheme.cpp \
        backend/localbackend.cpp \
        book.cpp \
        booklistmodel.cpp \
        main.cpp \
        notelistmodel.cpp \
        notemanager.cpp \
        notepreview.cpp

HEADERS += \
    backend/LocalBook.h \
    backend/backend.h \
    backend/localbackend.h \
    book.h \
    booklistmodel.h \
    notelistmodel.h \
    notemanager.h \
    notepreview.h
    #lib/mica/mica.h \
    #lib/modules/Fluent/fluentdesign.h \
     #lib/ostheme/ostheme.h

DISTFILES += \
    Fluent/README \
    FreshPaint-8-2022.06.01-01.36.32.png \
    lib/ostheme/LICENSE

RESOURCES += \
  resource.qrc

TRANSLATIONS += lang_id.ts

#CONFIG += qtquickcompiler

#include(lib/qtsingleapplication/src/qtsinglecoreapplication.pri)
#include(lib/FluentPlugin/fluentplugin.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += \
    $$PWD/lib/modules\
    $$PWD/qml

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
