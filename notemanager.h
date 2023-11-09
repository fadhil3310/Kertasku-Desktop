#ifndef NOTEMANAGER_H
#define NOTEMANAGER_H

#include <QQuickItem>
#include <QVariant>
#include <QSettings>

#include "backend/localbackend.h"
#include "booklistmodel.h"
#include "notelistmodel.h"
#include "book.h"
#include "notepreview.h"

class NoteManager : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(BookListModel* bookListModel READ bookListModel)
    Q_PROPERTY(NoteListModel* noteListModel READ noteListModel NOTIFY bookSelected)
    Q_PROPERTY(int selectedBook READ selectedBook WRITE setSelectedBook NOTIFY bookSelected)

public:
    NoteManager();

    BookListModel* bookListModel();
    NoteListModel* noteListModel();
    int selectedBook();

    void setSelectedBook(int index);

    bool modifyBook(int index, QString title);

    QList<NotePreview> getNoteList(int index);

    bool createBook(QString title, QMap<QString, QVariant> options, Book::StorageType storageType);

    // For QML
    Q_INVOKABLE void selectBook(int index);
    Q_INVOKABLE void createBookThumbnail(int bookIndex, QJSValue callback);
    Q_INVOKABLE bool createBook(QString title, QMap<QString, QVariant> options, QString storageType);

    Q_INVOKABLE bool writeNote(int bookIndex, int noteId, QMap<int, QString> changedContent);

signals:
    void bookSelected();

private:
    LocalBackend noteLocalBackend;

    QList<Book> books;
    BookListModel* m_bookListModel;
    NoteListModel* m_noteListModel;
    int m_selectedBook;

    QSettings settings;
};

#endif // NOTEMANAGER_H
