#ifndef MICA_H
#define MICA_H

#include <windef.h>

namespace MicaMaterial {
    enum MicaMaterialTheme {Auto, Light, Dark};

    void setWindowDark(HWND hWND);

    int enableForWindow(HWND hWND, bool isQtQuick = false, MicaMaterialTheme theme = MicaMaterialTheme::Auto);
}

#endif // MICA_H
