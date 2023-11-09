#include "fluenthelper_plugin.h"

#include "fluenthelper.h"
#include "micaenabler.h"
#include "navigationviewbackground.h"

#include <qqml.h>
#include <QGuiApplication>
#include <QPalette>

void FluentHelperPlugin::registerTypes(const char *uri)
{
    // @uri FluentDesign 
    /*qmlRegisterSingletonType<FluentHelper>(uri, 1, 0, "FluentHelper", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
            Q_UNUSED(engine)
            Q_UNUSED(scriptEngine)

            FluentHelper *fluentHelper = &FluentHelper::Get();
            return fluentHelper;
        });*/
    //QScopedPointer<FluentHelper> fluentHelper();
    qmlRegisterSingletonInstance(uri, 1, 0, "FluentHelper", &FluentHelper::Get());
    qmlRegisterType<MicaEnabler>(uri, 1, 0, "MicaEnabler");
    qmlRegisterType<NavigationViewBackground>(uri, 1, 0, "NavigationViewBackground");
}

