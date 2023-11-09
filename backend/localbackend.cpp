#include "localbackend.h"

LocalBackend::LocalBackend()
{
    // Windows specific code:
    if (QOperatingSystemVersion::currentType() == QOperatingSystemVersion::Windows) {
        defaultKertaskuPath = QDir::homePath() + "/Documents/Kertasku";
        if (!kertaskuDir.cd(defaultKertaskuPath))
            kertaskuDir.mkdir(defaultKertaskuPath);
    }
}

QList<Book> LocalBackend::getBookList()
{
    QList<Book> books;

    QStringList entryList;

    entryList = kertaskuDir.entryList();

    // Check every file in kertasku directory
    for (const QString &fileName : entryList) {
        qDebug() << "ZIP" << fileName;
        if (fileName.endsWith(".mdbk")) {
            QuaZip* zip = new QuaZip(defaultKertaskuPath + "/" + fileName);
            QString bookTitle;
            QJsonObject jsonObject;
            if (!zip->open(QuaZip::mdUnzip))
                //qDebug() << "Failed to open";
                continue;

            // Get book name
            if (zip->setCurrentFile("book.json")) {
                QuaZipFile metadata(zip);
                metadata.open(QIODevice::ReadOnly);
                QJsonDocument json = QJsonDocument::fromJson(metadata.readAll());

                /*if (json.isNull())
                    goto metadataFallback;*/

                jsonObject = json.object();
                bookTitle = jsonObject["title"].toString();

                metadata.close();

                qDebug() << "LocalBackend:" << "Metadata read from book.json";
            } else {
                bookTitle = fileName.split(".")[0];
                qDebug() << "LocalBackend:" << "Metadata not read from book.json";
            }

            zip->close();

            Book book(bookTitle, "123", Book::StorageType::Local);
            localBooks.append(LocalBook(book, jsonObject, defaultKertaskuPath + "/" + fileName));
            books.append(book);
        }
    }

    return books;
}

// Get note list in  book
QList<NotePreview> LocalBackend::getNoteList(int index)
{
    qDebug() << "LocalBackend:" << "Get note list for index" << index;

    QList<NotePreview> noteList;

    QuaZip* zip = new QuaZip(localBooks[index].path);

    // If book can't be opened, return empty noteList
    if (!zip->open(QuaZip::mdUnzip))
        return QList<NotePreview>();

    // Check every file in the book which extension is .md
    for (QString &fileName : zip->getFileNameList()) {
        if (fileName.endsWith(".md")) {
            if (!zip->setCurrentFile(fileName))
                continue;

            QuaZipFile* file = new QuaZipFile(zip);
            file->open(QIODevice::ReadOnly);

            QString title = getTitleFromNote(file);
            QString summary = getSummaryFromNote(file);

            noteList.append(NotePreview(title, summary));
        }
    }

    return noteList;
}

bool LocalBackend::createBook(QString title)
{
    QJsonObject metadata;
    metadata["title"] = title;

    LocalBook localBook(Book(title, "red", Book::Local), metadata, defaultKertaskuPath + "/" + title + ".mdbk");
    localBooks.append(localBook);

    QuaZip* zip = new QuaZip(localBook.path);
    if(!zip->open(QuaZip::mdCreate))
        return false;

    QuaZipFile metadataFile(zip);

    if(!metadataFile.open(QuaZipFile::OpenModeFlag::WriteOnly, QuaZipNewInfo("book.json")))
        return false;

    metadataFile.write(QJsonDocument(metadata).toJson());

    metadataFile.close();
    zip->close();

    if(zip->getZipError() != UNZ_OK)
        return false;

    return true;
}

bool LocalBackend::modifyBook(int index, QString title)
{
    LocalBook *localBook = &localBooks[index];

    QuaZip* zip = new QuaZip(localBook->path);
    if(!zip->open(QuaZip::mdAdd))
        return false;

    zip->setCurrentFile("book.json");

    localBook->jsonObject["title"] = title;
    QByteArray modifiedMetadata = QJsonDocument(localBook->jsonObject).toJson();

    QuaZipFile metadata(zip);
    metadata.open(QIODevice::WriteOnly);
    metadata.write(modifiedMetadata);
    metadata.close();

    zip->close();

    return true;
}

QString LocalBackend::getTitleFromNote(QuaZipFile* file)
{
    // Get the title of the note by reading the first line of the note
    QString title;

    bool stopReading = false;
    int lineRead = 0;

    while (!stopReading) {
        qDebug() << "Read title";
        char buf[2048];
        qint64 readLength = file->readLine(buf, sizeof(buf));

        if (lineRead < 10) {
            if (readLength != -1) {
                // Check if the line is a title
                QString temporaryTitle = buf;
                if (temporaryTitle.startsWith("#")) {
                    // Remove # and \n (newline character)
                    temporaryTitle.replace("#", "");
                    temporaryTitle.replace("\n", "");
                    title = temporaryTitle;

                    qDebug() << title;
                    stopReading = true;
                } else {
                    lineRead++;
                }
            } else {
                lineRead++;
            }
        } else {
            stopReading = true;
        }
    }

    return title;
}

QString LocalBackend::getSummaryFromNote(QuaZipFile* file)
{
    // Get the summary of the note
    QString summary;

    bool stopReading = false;
    bool foundFirstNotEmptyLine = false;
    int lineRead = 0;

    while (!stopReading) {
        qDebug() << "Read summary" << lineRead;
        char buf[2048];
        qint64 readLength = file->readLine(buf, sizeof(buf));

        if (readLength != -1 && lineRead < 5) {
            QString temporaryText = buf;

            qDebug() << "Text:" << temporaryText;

            if (!foundFirstNotEmptyLine) {
                temporaryText.replace("\r", "");
                temporaryText.replace("\n", "");

                if (!temporaryText.isEmpty()) {
                    foundFirstNotEmptyLine = true;
                    summary += buf;
                }
            } else {
                summary += buf;
            }

            lineRead++;
        } else {
            stopReading = true;
        }
    }

    qDebug() << summary;

    return summary;
}
