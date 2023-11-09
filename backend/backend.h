#ifndef BACKEND_H
#define BACKEND_H

#include "book.h"
#include "notepreview.h"

class Backend {
public:
    virtual QList<Book> getBookList();
    virtual QList<NotePreview> getNoteList(int index);
    virtual bool createBook(QString title);
    virtual bool modifyBook(int index, QString title);
};

#endif // BACKEND_H
