#include "notelistmodel.h"

NoteListModel::NoteListModel(QList<NotePreview> &notes, QObject *parent)
    : QAbstractListModel(parent), m_notes(notes)
{
}

int NoteListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!

    return m_notes.count();
}

QVariant NoteListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    NotePreview note = m_notes[index.row()];

    switch (role) {
    case TitleRole:
        return note.title;
    case ContentRole:
        return note.content;
    }

    return QVariant();
}

bool NoteListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        switch (role) {
        case TitleRole:
            m_notes[index.row()].title = value.toString();
            break;
        case ContentRole:
            m_notes[index.row()].content = value.toString();
            break;
        }

        emit dataChanged(index, index, {role});
        return true;
    }

    return false;
}

Qt::ItemFlags NoteListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return QAbstractItemModel::flags(index) | Qt::ItemIsEditable; // FIXME: Implement me!
}

bool NoteListModel::addNote(NotePreview note)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_notes << note;
    endInsertRows();

    return true;
}

bool NoteListModel::removeNote(int &index)
{
    if (index < m_notes.count()) {
        beginRemoveRows(QModelIndex(), index, index);
        m_notes.removeAt(index);
        endRemoveRows();

        return true;
    }

    return false;
}

QHash<int, QByteArray> NoteListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[ContentRole] = "content";
    return roles;
}

