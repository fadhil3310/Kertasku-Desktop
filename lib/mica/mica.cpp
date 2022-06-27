#include "mica.h"
#include "lib/ostheme/ostheme.h"

#include <dwmapi.h>

void setWindowDark(HWND hWND) {
    int value = 1;
    DwmSetWindowAttribute(hWND, 20, &value, sizeof(value));
}

void extendFrameIntoClientArea(HWND hWND) {
    // Adapted from https://github.com/martinet101/win32mica/blob/main/src/win32mica/__init__.py
    MARGINS margin = {-1, -1, -1, -1};
    DwmExtendFrameIntoClientArea(hWND, &margin);
}

void MicaMaterial::enableForWindow(HWND hWND, MicaMaterialTheme theme) {
    // If theme is dark, tell Dwm to use immersive dark mode for the window
    switch (theme) {
        case MicaMaterialTheme::Auto:
            if(!OSTheme::isLight())
                setWindowDark(hWND);
            break;
        case MicaMaterialTheme::Light:
            break;
        case MicaMaterialTheme::Dark:
            setWindowDark(hWND);
            break;
    }

    // To fix black background when setting the window background to transparent
    extendFrameIntoClientArea(hWND);

    // Adapted from https://github.com/Simnico99/MicaWPF/blob/main/src/MicaWPF/Interop/InteropValues.cs
    // Tell Dwm to use mica backdrop for the window
    int value = 1;
    DwmSetWindowAttribute(hWND, 1029, &value, sizeof(value));
}
