#include "mica.h"
#include "../ostheme/ostheme.h"

#include <dwmapi.h>

#include <QOperatingSystemVersion>

void MicaMaterial::setWindowDark(HWND hWND) {
    int value = 1;
    DwmSetWindowAttribute(hWND, 20, &value, sizeof(value));
}

void extendFrameIntoClientArea(HWND hWND) {
    // Adapted from https://github.com/martinet101/win32mica/blob/main/src/win32mica/__init__.py
    MARGINS margin = {-1, -1, -1, -1};
    DwmExtendFrameIntoClientArea(hWND, &margin);
}

int MicaMaterial::enableForWindow(HWND hWND, bool isQtQuick, MicaMaterialTheme theme) {
    // If theme is dark, tell Dwm to use immersive dark mode for the window
    switch (theme) {
        case MicaMaterialTheme::Auto:
            if (OSTheme::isLight()) {

            } else {

            }
        case MicaMaterialTheme::Light:
            break;
        case MicaMaterialTheme::Dark:
            setWindowDark(hWND);
            break;
    }

    // To fix black background when setting the window background to transparent on Qt Widget
    if (!isQtQuick)
        extendFrameIntoClientArea(hWND);

    // Adapted from https://github.com/Simnico99/MicaWPF/
    // Tell Dwm to use mica backdrop for the window
    if (QOperatingSystemVersion(QOperatingSystemVersion::Windows, 10, 22523) >= QOperatingSystemVersion::current()) {
        int value = 2;
        DwmSetWindowAttribute(hWND, 38, &value, sizeof(value));
    } else {
        int value = 1;
        DwmSetWindowAttribute(hWND, 1029, &value, sizeof(value));
    }


    return 0;
}
