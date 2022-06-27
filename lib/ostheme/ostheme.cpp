#include "ostheme.h"

#include <Windows.h>
#include <winreg.h>
#include <QDebug>
#include <QSysInfo>


bool OSTheme::isLight() {
    if (QSysInfo::kernelType() == "winnt") {
        DWORD type;
        DWORD isLight;
        DWORD isLightLength = sizeof(isLight);
        int getResult = RegGetValueA(HKEY_CURRENT_USER,
                     "Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize",
                     "AppsUseLightTheme",
                     RRF_RT_REG_DWORD,
                     (LPDWORD)&type,
                     &isLight,
                     &isLightLength);
        //errorCode("getResult", getResult);
        if (getResult == 0) {
           return false;
        } else {
            return true;
        }
    } else {
        qWarning() << "Can't detect operating system, returning true";
        return true;
    }
}
