import QtQuick 2.15
import QtQuick.Controls 2.15
import FluentHelper 1.0
import FluentIcons 1.0

Button {
    id: control

    implicitHeight: fluentIcon.height + implicitContentHeight + topPadding + bottomPadding + 2
    implicitWidth: implicitHeight

    property bool selected
    property string iconName
    property string iconColor: FluentHelper.isLight ? "#000000" : "#FFFFFF"

    background: Rectangle {
        color: "#00000000"
        radius: 8

        border.color: control.highlighted || control.visualFocus ?
                          "white" : "transparent"
        border.width: 2
    }

    FluentIcon {
        id: fluentIcon

        anchors {
            top: control.top
            horizontalCenter: control.horizontalCenter
            margins: {
                top: control.topPadding
            }
        }

        iconName: parent.iconName + "_nav"
        color: parent.iconColor

        scale: 1

        transform: Translate {
            id: fluentIconTranslate
            y: 0
            Behavior on y { NumberAnimation { duration: 100 } }
        }

        Behavior on scale {
            NumberAnimation { duration: 100; easing.type: Easing.OutBack }
        }
    }

    contentItem: Text {
        anchors {
            top: fluentIcon.bottom
            margins: {
                top: 4
            }
        }
        horizontalAlignment: Text.AlignHCenter

        text: control.text
        color: control.color ? control.color : "white"

        //opacity: control.down ? 0.8 : 1
    }

    states: [
        State {
            name: "selected"
            when: control.selected
            PropertyChanges {
                target: background
                color: FluentHelper.isLight ? "#08000000" : "#10ffffff"
            }
            PropertyChanges {
                target: fluentIcon
                iconName: parent.iconName + "_nav_selected"
                color: "yellow"

            }
        },
        State {
            name: "down"
            when: control.down
            PropertyChanges {
                target: background
                color: FluentHelper.isLight ? "#08000000" : "#10ffffff"
            }
            PropertyChanges {
                target: fluentIcon
                opacity: 0.8
                scale: 0.9
            }
            PropertyChanges {
                target: contentItem
                opacity: 0.8
            }
            PropertyChanges {
                target: fluentIconTranslate
                y: 3
            }

        },
        State {
            name: "hovered"
            when: control.hovered

            PropertyChanges {
                target: background
                color: FluentHelper.isLight ? "#08000000" : "#15ffffff"
            }

        }
    ]
}
