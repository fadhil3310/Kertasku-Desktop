#ifndef NAVIGATIONVIEWBACKGROUND_H
#define NAVIGATIONVIEWBACKGROUND_H

#include <QQuickPaintedItem>

class NavigationViewBackground : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor)
    QML_ELEMENT

public:
    NavigationViewBackground(QQuickItem *parent = nullptr);

    QColor color() const;
    void setColor(const QColor &color);

    void paint(QPainter *painter) override;

private:
    QColor m_color;
};

#endif // NAVIGATIONVIEWBACKGROUND_H
