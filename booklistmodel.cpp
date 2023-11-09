#include "booklistmodel.h"

BookListModel::BookListModel(QList<Book> &books, QObject *parent)
    : QAbstractListModel(parent)
{
    m_books = books;
}

int BookListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_books.count();
}

QVariant BookListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    Book book = m_books[index.row()];

    switch (role) {
    case TitleRole:
        return book.title;
    case CoverRole:
        return book.cover;
    /*case NoteThumbnailCount:
        return book.noteThumbnailCount;
    case NoteThumbnailContent:
        return book.noteThumbnailContent;*/
    }

    return QVariant();
}

bool BookListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        switch (role) {
        case TitleRole:
            m_books[index.row()].title = value.toString();
            break;
        case CoverRole:
            m_books[index.row()].cover = value.toString();
            break;
        }

        emit dataChanged(index, index, {role});
        return true;
    }

    return false;
}

Qt::ItemFlags BookListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return QAbstractItemModel::flags(index) | Qt::ItemIsEditable; // FIXME: Implement me!
}

bool BookListModel::addBook(Book book)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_books << book;
    endInsertRows();

    return true;
}

bool BookListModel::removeBook(int &index)
{
    if (index < m_books.count()) {
        beginRemoveRows(QModelIndex(), index, index);
        m_books.removeAt(index);
        endRemoveRows();

        return true;
    }

    return false;
}

QHash<int, QByteArray> BookListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[CoverRole] = "cover";
    roles[NoteThumbnailCount] = "thumbnailCount";
    roles[NoteThumbnailContent] = "thumbnailContent";
    return roles;
}
