#include "settings.h"
#include <Windows.h>
#include <winreg.h>
#include <QDebug>

//using namespace WindowsSettings;

void getIsScrollbarDynamic(void onResult(bool isDynamic)) {

    HKEY hKey;
    LPCWSTR subKey = LPCWSTR("Control Panel\\Accesibility");
    if (!RegOpenKeyEx(HKEY_CURRENT_USER,
                     subKey,
                     NULL,
                     KEY_READ,
                     &hKey)) {
        qDebug() << "getIsScrollbarDynamic:" << "Open key failed";
        onResult(true);
        return;
    }

    DWORD type;
    DWORD isDynamic;
    DWORD isDynamicLength = sizeof(isDynamic);
    if(!RegGetValueA(hKey,
                 NULL,
                 "DynamicScrollbars",
                 RRF_RT_REG_DWORD,
                 (LPDWORD)&type,
                 &isDynamic,
                 &isDynamicLength)) {
        qDebug() << "getIsScrollbarDynamic:" << "Get value failed";
        onResult(true);
        return;
    }
    onResult(isDynamic);

    auto event = CreateEventA(NULL, true, false, NULL);
    RegNotifyChangeKeyValue(hKey,
                            false,
                            REG_NOTIFY_CHANGE_LAST_SET,
                            event, true);

};
