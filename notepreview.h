#ifndef NOTEPREVIEW_H
#define NOTEPREVIEW_H

#include <QString>

class NotePreview
{
public:
    NotePreview(const QString &title, const QString &content);

    QString title;
    QString content;
};

#endif // NOTEPREVIEW_H
