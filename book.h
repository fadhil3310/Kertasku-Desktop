#ifndef BOOK_H
#define BOOK_H

#include <QString>

class Book
{
public:
    enum StorageType {
        Local,
        Supabase,
        KertaskuServer
    };

    Book(const QString &title, const QString &cover, const StorageType &storageType);

    QString title;
    QString cover;
    StorageType storageType;
    int noteThumbnailCount;
    QString noteThumbnailContent;
};



#endif // BOOK_H
