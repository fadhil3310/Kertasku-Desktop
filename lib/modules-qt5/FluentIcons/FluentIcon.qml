import QtQuick 2.15
import QtGraphicalEffects 1.15
import FluentHelper 1.0

Image {
    id: control

    property string color: "default"
    property string iconName: ""
    property int iconSize: 0

    source: if (iconSize !== 0) {
              return "qrc:/lib/modules/FluentIcons-shared/" + iconName + "_" + iconSize + ".svg"
            } else {
              return "qrc:/lib/modules/FluentIcons-shared/" + iconName + ".svg"
            }

    fillMode: Image.PreserveAspectFit

    layer {
        enabled: color != ""

        effect: ColorOverlay {
            color: control.color == "default" ? (FluentHelper.isLight ? "black" : "white") : control.color
        }
    }
}
