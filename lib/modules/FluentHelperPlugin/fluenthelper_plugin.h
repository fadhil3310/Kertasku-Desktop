#ifndef FLUENTHELPER_PLUGIN_H
#define FLUENTHELPER_PLUGIN_H

#include <QQmlExtensionPlugin>

class FluentHelperPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void registerTypes(const char *uri) override;
};

#endif // FLUENTHELPER_PLUGIN_H
