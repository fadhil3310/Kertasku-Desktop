#include "fluenthelper.h"
#include <QDebug>
#include "ostheme/ostheme.h"
#include "mica/mica.h"
#include <QOperatingSystemVersion>
#include "windows/settings.cpp"

FluentHelper::FluentHelper(QObject *parent)
    : QObject{parent}
{   
    qDebug() << "created";

    if(OSTheme::isLight()) {
        qDebug() << "mode light";
        setIsLight(true);
    }
    else  {
        qDebug() << "mode dark";
        setIsLight(false);
    }

#ifdef Q_OS_WIN   
    if (QOperatingSystemVersion::current() >= QOperatingSystemVersion::Windows10) {
        // Check if user enabled always expand scrollbar on Windows Settings

        //errorCode("getResult", getResult);
        // TODO: handle getResult
        /*if (isDynamic == 0) {
           setAlwaysExpandScrollbar(true);
           qDebug() << "always";
        }*/

        if (QOperatingSystemVersion::current() >= QOperatingSystemVersion(QOperatingSystemVersion::Windows, 10, 0, 22000)) {
            // Set micaEnabled to true so MicaEnabler know that mica is enabled
            qDebug() << "Running on windows 11 and fluent style, enabling mica";
            setMicaEnabled(true);
        }
    }
#endif

}

/*FluentHelper::~FluentHelper() {
    qDebug() << "Deleting FluentHelper";
}*/

bool FluentHelper::isLight() const {
    return m_isLight;
}

void FluentHelper::setIsLight(const bool &isLight) {
    qDebug() << "set mode";
    m_isLight = isLight;
    emit isLightChanged();
}

bool FluentHelper::micaEnabled() const {
    qDebug() << "is mica enabled" << m_micaEnabled;
    return m_micaEnabled;
}
void FluentHelper::setMicaEnabled(const bool &micaEnabled) {
    m_micaEnabled = micaEnabled;
    emit micaEnabledChanged();
}

bool FluentHelper::alwaysExpandScrollbar() const {
    return m_alwaysExpandScrollbar;
}
void FluentHelper::setAlwaysExpandScrollbar(const bool &alwaysExpand) {
    m_alwaysExpandScrollbar = alwaysExpand;
    emit alwaysExpandScrollbarChanged();
}

/*QColor FluentDesign::windowColor() const {
    return m_windowColor;
}
void FluentDesign::setWindowColor(const QColor &color) {
    m_windowColor = color;
    //emit windowColorChanged();
}

QColor FluentDesign::scrollBarBackground() const {
    return m_windowColor;
}
void FluentDesign::setScrollBarBackground(const QColor &color) {
    m_windowColor = color;
    //emit windowColorChanged();
}*/
