#ifndef BOOKLISTMODEL_H
#define BOOKLISTMODEL_H

#include <QAbstractListModel>

#include "book.h"

class BookListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit BookListModel(QList<Book> &books, QObject *parent = nullptr);

    enum BookListRoles {
        TitleRole,
        CoverRole,
        NoteThumbnailCount,
        NoteThumbnailContent
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    // Add and remove data:
    bool addBook(Book book);
    bool removeBook(int &index);

private:
    QList<Book> m_books;

protected:
    QHash<int, QByteArray> roleNames() const override;
};

#endif // BOOKLISTMODEL_H
