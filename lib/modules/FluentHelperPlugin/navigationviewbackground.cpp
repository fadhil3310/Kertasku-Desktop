#include "navigationviewbackground.h"
#include "qcursor.h"

#include <QPainter>
#include <QDebug>

NavigationViewBackground::NavigationViewBackground(QQuickItem *parent) : QQuickPaintedItem(parent)
{

}

QColor NavigationViewBackground::color() const {
    return m_color;
}

void NavigationViewBackground::setColor(const QColor &color) {
    m_color = color;
}

void NavigationViewBackground::paint(QPainter *painter) {
    painter->setPen(Qt::transparent);
    painter->setBrush(m_color);
    painter->setRenderHint(QPainter::Antialiasing);
    painter->drawPie(0, 0, 20, 20, 90 * 16, 90 * 16);
    painter->drawRect(10, 0, this->width() - 10, 10);
    painter->drawRect(0, 10, this->width(), this->height());
    painter->setPen(QColor("#91000000"));
    painter->drawArc(0, 0, 20, 20, 90 * 16, 90 * 16);
    painter->drawLine(10, 0, this->width(), 0);
    painter->drawLine(0, 10, 0, this->height());
    //QBitmap cursor = QCursor(Qt::ArrowCursor).bitmap();
}
