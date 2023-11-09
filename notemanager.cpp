#include "notemanager.h"
#include <QRandomGenerator>

NoteManager::NoteManager()
{
    //settings.setValue("backend/local", true);
    if (settings.value("backend/local").toBool() == true) {
        for(Book &book : noteLocalBackend.getBookList()) {
            books.append(book);
            qDebug() << book.title;
        }
    }
    if (settings.value("backend/supabase").toBool() == true) {

    }
    if (settings.value("backend/kertaskuServer").toBool() == true) {

    }

    QList<NotePreview> notePreview = getNoteList(0);

    m_bookListModel = new BookListModel(books);
    m_noteListModel = new NoteListModel(notePreview);
}

BookListModel* NoteManager::bookListModel() {
    return m_bookListModel;
}

NoteListModel* NoteManager::noteListModel()
{
    return m_noteListModel;
}

int NoteManager::selectedBook()
{
    return m_selectedBook;
}

void NoteManager::setSelectedBook(int index)
{
    m_selectedBook = index;
    emit bookSelected();
}

bool NoteManager::createBook(QString title, QMap<QString, QVariant> options, Book::StorageType storageType)
{
    bool result;

    //if (QMetaType::type(options["color"].metaType().name()) == QMetaType::QString) {

    //}

    switch (storageType) {
    case Book::Local: {
        result = noteLocalBackend.createBook(title);
        break;
    }
    }
    return result;
}

bool NoteManager::createBook(QString title, QMap<QString, QVariant> options, QString storageType)
{
    bool result;


    if (storageType == "local") result = createBook(title, options, Book::Local);
    else if (storageType == "supabase") result = createBook(title, options, Book::Supabase);

    return result;
}

bool NoteManager::modifyBook(int index, QString title)
{
    Book book = books[index];
    book.title = title;
    switch (book.storageType) {
        case Book::StorageType::Local:
            noteLocalBackend.modifyBook(index, title);
            break;
    }

    return true;
}

QList<NotePreview> NoteManager::getNoteList(int index)
{

    QList<NotePreview> notePreview;

    switch (books[index].storageType) {
        case Book::StorageType::Local:
            notePreview = noteLocalBackend.getNoteList(index);
            break;
    }

    return notePreview;
}

void NoteManager::selectBook(int index)
{
    QList<NotePreview> notePreview = getNoteList(index);
    m_noteListModel = new NoteListModel(notePreview);
    setSelectedBook(index);
    emit bookSelected();
}

void NoteManager::createBookThumbnail(int index, QJSValue callback)
{
    qDebug() << "Get note thumbnail" << index;
    QJSValueList list;


    quint32 random = QRandomGenerator::global()->bounded(0, 3);
    qDebug() << "random:" << random;
    list.append(random);
    list.append("Abc");
    callback.call(list);
}

bool NoteManager::writeNote(int bookId, int noteId, QMap<int, QString> changedContent)
{

}
