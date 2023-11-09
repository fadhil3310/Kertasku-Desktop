#include "book.h"

Book::Book(const QString &_title, const QString &_cover, const StorageType &_storageType/*,
           const int &_noteThumbnailCount, const QString &_noteThumbnailContent*/)
    : title(_title), cover(_cover), storageType(_storageType)/*,
      noteThumbnailCount(_noteThumbnailCount), noteThumbnailContent(_noteThumbnailContent)*/
{}

