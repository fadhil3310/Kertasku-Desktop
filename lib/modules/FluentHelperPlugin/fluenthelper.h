#ifndef FLUENTHELPER_H
#define FLUENTHELPER_H

#include "mica/mica.h"
#include <QtGlobal>
#include <QColor>
#include <QQmlEngine>

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
 #include <QtQml/qqml.h>
#else
 #include <QtQml/qqmlregistration.h>
#endif

#include <QQuickItem>

#include <QObject>

#include <QQuickWindow>

class FluentHelper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isLight READ isLight WRITE setIsLight NOTIFY isLightChanged)
    Q_PROPERTY(bool micaEnabled READ micaEnabled WRITE setMicaEnabled NOTIFY micaEnabledChanged)
    Q_PROPERTY(bool alwaysExpandScrollbar READ alwaysExpandScrollbar WRITE setAlwaysExpandScrollbar NOTIFY alwaysExpandScrollbarChanged)
    //Q_PROPERTY(QQuickWindow enableMica READ enableMica WRITE setEnableMica)
    //Q_PROPERTY(QColor windowColor READ windowColor WRITE setWindowColor NOTIFY windowColorChanged)
    //Q_PROPERTY(QColor scrollBarBackground READ scrollBarBackground WRITE setScrollBarBackground)
    QML_SINGLETON
    QML_ELEMENT

public:
    static FluentHelper& Get() {
        static FluentHelper s_instance;
        return s_instance;
    }

    //~FluentHelper();

    /*enum class ThemeMode {
        LIGHT,
        DARK
    };
    Q_ENUM(ThemeMode)*/

    bool isLight() const;
    void setIsLight(const bool &isLight);

    /*QColor windowColor() const;
    void setWindowColor(const QColor &color);

    QColor scrollBarBackground() const;
    void setScrollBarBackground(const QColor &color);*/

    bool micaEnabled() const;
    void setMicaEnabled(const bool &micaEnabled);

    bool alwaysExpandScrollbar() const;
    void setAlwaysExpandScrollbar(const bool &alwaysExpand);

    /*QQuickWindow m_enableMica;

    QQuickWindow enableMica() {
        return m_enableMica;
    }

    void setEnableMica(QQuickWindow window) {
        qDebug() << "enable mica";

        if (FluentHelper::Get().micaEnabled()) {
            qDebug() << "mica enabled";

            MicaMaterial::MicaMaterialTheme mode;
            if(FluentHelper::Get().isLight())
                mode = MicaMaterial::MicaMaterialTheme::Light;
            else
            mode = MicaMaterial::MicaMaterialTheme::Dark;


               // m_window->setWidth(800);
                //m_window->winId();

            MicaMaterial::enableForWindow(HWND(window.winId()), true, mode);
        } else {
            qDebug() << "mica disabled";
        }
        qDebug() << "enable mica finish";
    };*/

signals:
    /*void modeChanged();
    void windowColorChanged();*/
    void isLightChanged();
    void micaEnabledChanged();
    void alwaysExpandScrollbarChanged();

private:
    explicit FluentHelper(QObject *parent = nullptr);
    //explicit FluentHelper(QObject *parent = nullptr);

    /*int m_mode = 0;
    QColor m_windowColor = QColor("transparent");
    QColor m_scrollBarBackground = QColor("transparent");*/
    bool m_isLight = true;
    bool m_micaEnabled = false;
    bool m_alwaysExpandScrollbar = false;
};

#endif // FLUENTHELPER_H
