import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Layouts 1.15
import FluentHelper 1.0
import FluentIcons 1.0

T.ScrollBar {
    id: control
    implicitWidth: 12
    implicitHeight: 100
    orientation: Qt.Vertical

    opacity: control.policy === ScrollBar.AlwaysOn || (control.size < 1) ? 1 : 0

    background: Rectangle {
        id: scrollBarBackground
        color: FluentHelper.isLight ? "#FEFEFE" : "#05FFFFFF"
        radius: this.width / 2
        opacity: 0
    }

    Button {
        id: incrementButton
        anchors.top: parent.top
        anchors.topMargin: 2
        width: 12
        height: 12
        background: StepButton
        opacity: 0
        focusPolicy: Qt.NoFocus

        onClicked: control.decrease()

        FluentIcon {
            iconName: "CaretUp"
            sourceSize.width: 12
            sourceSize.height: 12
            color: FluentHelper.isLight? "gray" : "#808080"
        }
    }

    contentItem: Item {
        Rectangle {
            id: scrollMover
            radius: this.width / 2
            anchors.fill: parent
            anchors.topMargin: 15
            anchors.bottomMargin: 15
            anchors.leftMargin: 7
            anchors.rightMargin: 3
            //Layout.fillWidth: true
            //Layout.fillHeight: true
            //Layout.topMargin: 14
            //Layout.bottomMargin: 14
            //Layout.leftMargin: 7
            //Layout.rightMargin: 3
            color: "#808080"
        }
    }

    Button {
        id: decrementButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
        width: 12
        height: 12
        background: StepButton
        opacity: 0
        focusPolicy: Qt.NoFocus

        onClicked: control.increase()

        FluentIcon {
            iconName: "CaretDown"
            sourceSize.width: 12
            sourceSize.height: 12
            color: FluentHelper.isLight? "gray" : "#808080"
        }
    }

    component StepButton: Rectangle {

    }

    states: [
        State {
            name: "expand"
            when: control.hovered || control.pressed //|| FluentHelper.alwaysExpandScrollbar
            PropertyChanges {
                target: scrollMover
                anchors.leftMargin: 3
            }
            PropertyChanges {
                target: incrementButton
                opacity: 1
            }
            PropertyChanges {
                target: decrementButton
                opacity: 1
            }
            PropertyChanges {
                target: scrollBarBackground
                opacity: 1
            }
        }
    ]

    transitions: Transition {
        ParallelAnimation {
            NumberAnimation {
                properties: "opacity,anchors.leftMargin"
                duration: 100
            }
        }
    }
}
