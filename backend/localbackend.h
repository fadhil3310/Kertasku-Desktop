#ifndef LOCALBACKEND_H
#define LOCALBACKEND_H

#include <QOperatingSystemVersion>
#include <QDir>
#include <QJsonDocument>
#include <QJsonObject>

#include <quazip/quazip.h>
#include <quazip/quazipfile.h>

#include "backend.h"
#include "LocalBook.h"

// Get book from local storage

class LocalBackend //: Backend, Inheriting class in Qt 5 will crash the app
{
public:
    LocalBackend();


    // Backend interface
    QList<Book> getBookList() ;
    QList<NotePreview> getNoteList(int index) ;
    bool createBook(QString title) ;
    bool modifyBook(int index, QString title) ;

private:
    QString getTitleFromNote(QuaZipFile* file);
    QString getSummaryFromNote(QuaZipFile* file);

    QString defaultKertaskuPath;
    QList<LocalBook> localBooks;
    QDir kertaskuDir;
};

#endif // LOCALBACKEND_H
