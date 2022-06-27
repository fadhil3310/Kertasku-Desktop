#ifndef MICA_H
#define MICA_H

#include <windef.h>

namespace MicaMaterial {
    enum MicaMaterialTheme {Auto, Light, Dark};

    void enableForWindow(HWND hWND, MicaMaterialTheme theme = MicaMaterialTheme::Auto);
}

#endif // MICA_H
