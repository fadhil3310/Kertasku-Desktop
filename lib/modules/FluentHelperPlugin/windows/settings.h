#ifndef SETTINGS_H
#define SETTINGS_H


#include <QList>

class WindowsSettings {

private:
    QList<char> callbackList;
public:
    void getIsAlwaysExpandScrollbar(void onResult(bool isAlways));
};

#endif // SETTINGS_H
