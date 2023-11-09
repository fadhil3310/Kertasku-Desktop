#ifndef LOCALBOOK_H
#define LOCALBOOK_H

#include "book.h"
#include "qjsonobject.h"

class LocalBook
{
public:
    LocalBook(const Book &_book, const QJsonObject &_jsonObject, const QString &_path)
        : book(_book), jsonObject(_jsonObject), path(_path) {};

    Book book;
    QJsonObject jsonObject;
    QString path;
};

#endif // LOCALBOOK_H
