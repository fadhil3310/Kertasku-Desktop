#ifndef MICAENABLER_H
#define MICAENABLER_H

#include <QQuickItem>
#include <QQuickWindow>

#include "mica/mica.h"
#include "ostheme/ostheme.h"


class MicaEnabler : public QQuickItem
{
    Q_OBJECT
    //Q_PROPERTY(bool enabled READ enabled WRITE setEnabled)
    Q_PROPERTY(QQuickWindow* window READ window WRITE setWindow)
    Q_PROPERTY(QColor fallbackColorLight READ fallbackColorLight WRITE setFallbackColorLight)
    Q_PROPERTY(QColor fallbackColorDark READ fallbackColorDark WRITE setFallbackColorDark)

public:
    MicaEnabler();

    bool enabled() const;
    void setEnabled(const bool &enabled);

    QQuickWindow* window() const;
    void setWindow(QQuickWindow* window);

    QColor fallbackColorLight() const;
    void setFallbackColorLight(const QColor &color);

    QColor fallbackColorDark() const;
    void setFallbackColorDark(const QColor &color);

signals:

private:
    bool m_enabled = true;
    QQuickWindow* m_window;
    QColor m_fallbackColorLight;
    QColor m_fallbackColorDark;
};

#endif // MICAENABLER_H
