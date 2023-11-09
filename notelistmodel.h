#ifndef NOTELISTMODEL_H
#define NOTELISTMODEL_H

#include <QAbstractListModel>

#include "notepreview.h"

class NoteListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit NoteListModel(QList<NotePreview> &notes, QObject *parent = nullptr);

    enum NoteListRoles {
        TitleRole,
        ContentRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    // Add and remove data:
    bool addNote(NotePreview note);
    bool removeNote(int &index);

private:
    QList<NotePreview> m_notes;

protected:
    QHash<int, QByteArray> roleNames() const override;
};

#endif // NOTELISTMODEL_H
