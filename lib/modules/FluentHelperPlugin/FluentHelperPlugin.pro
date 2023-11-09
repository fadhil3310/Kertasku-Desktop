TEMPLATE = lib
TARGET = FluentHelperPlugin
QT += qml quick quickcontrols2
CONFIG += plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = FluentHelper

DESTDIR = $$OUT_PWD/../../../FluentHelper


win32 {
    LIBS += -ldwmapi
}

# Input
SOURCES += \
        fluenthelper.cpp \
        fluenthelper_plugin.cpp \
        mica/mica.cpp \
        micaenabler.cpp \
        navigationviewbackground.cpp \
        ostheme/ostheme.cpp \
        windows/settings.cpp

HEADERS += \
        fluenthelper.h \
        fluenthelper_plugin.h \
        mica/mica.h \
        micaenabler.h \
        navigationviewbackground.h \
        ostheme/ostheme.h \
        windows/settings.h

DISTFILES = qmldir \
    #FluentItem.qml \
    ostheme/LICENSE


QML_IMPORT_PATH = $$PWD/

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) "$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)" "$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}

cpqmldir.files = qmldir
cpqmldir.path = $$DESTDIR

#cptest.files = FluentItem.qml
#cptest.path = $$DESTDIR

COPIES += cpqmldir #cptest
