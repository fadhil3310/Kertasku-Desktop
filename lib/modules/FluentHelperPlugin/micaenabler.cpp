#include "micaenabler.h"
#include "fluenthelper.h"

MicaEnabler::MicaEnabler()
{

}

/*void MicaApplicationWindow::enableMica(QQuickWindow window) {
    qDebug() << "enable mica";
}*/

/*bool MicaEnabler::enabled() const {
    return m_enabled;
}
void MicaEnabler::setEnabled(const bool &enabled) {
    m_enabled = enabled;
}*/

QQuickWindow* MicaEnabler::window() const {
    qDebug() << "get window";
    return m_window;
}
void MicaEnabler::setWindow(QQuickWindow* window) {
    qDebug() << "set window";
    m_window = window;

    MicaMaterial::MicaMaterialTheme mode;
    if(FluentHelper::Get().isLight())
        mode = MicaMaterial::MicaMaterialTheme::Light;
    else
        mode = MicaMaterial::MicaMaterialTheme::Dark;

    if (m_enabled && FluentHelper::Get().micaEnabled()) {
        qDebug() << "mica enabled";

        m_window->setColor("transparent");
        MicaMaterial::enableForWindow(HWND(m_window->winId()), true, mode);
    } else {      
        qDebug() << "mica disabled";

        if(mode == MicaMaterial::MicaMaterialTheme::Light) {
            m_window->setColor(m_fallbackColorLight);
        } else if(mode == MicaMaterial::MicaMaterialTheme::Dark) {
            m_window->setColor(m_fallbackColorDark);
            MicaMaterial::setWindowDark(HWND(m_window->winId()));
        }
    }

    qDebug() << "set window finish";
}

QColor MicaEnabler::fallbackColorLight() const {
    return m_fallbackColorLight;
}
void MicaEnabler::setFallbackColorLight(const QColor &color) {
    m_fallbackColorLight = color;
}

QColor MicaEnabler::fallbackColorDark() const {
    return m_fallbackColorDark;
}
void MicaEnabler::setFallbackColorDark(const QColor &color) {
    m_fallbackColorDark = color;
}
