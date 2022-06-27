QT += quick quickcontrols2

win32 {
    LIBS += -ldwmapi
}

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        lib/mica/mica.cpp \
        lib/ostheme/ostheme.cpp \
        main.cpp

RESOURCES += qml.qrc

CONFIG+=qtquickcompiler

include(lib/qtsingleapplication/src/qtsinglecoreapplication.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    lib/ostheme/LICENSE

HEADERS += \
    lib/mica/mica.h \
    lib/ostheme/ostheme.h
