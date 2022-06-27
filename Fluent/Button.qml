import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Button {
    id: button

    implicitWidth: buttonText.width + 20
    implicitHeight: 30

    property string color

    background: Rectangle {
        color: if (button.down) {
                   return "#08ffffff"
               } else if(button.hovered) {
                   return "#15ffffff"
               } else {
                   return "#10ffffff"
               }

        radius: 8
        border.color: if (button.focus && (button.focusReason === Qt.TabFocusReason || button.focusReason === Qt.BacktabFocusReason)) {
                          return "white"
                      } else if (button.hovered) {
                          return "#12ffffff"
                      } else {
                          return "#17ffffff"
                      }

        border.width: (button.focus && (button.focusReason === Qt.TabFocusReason || button.focusReason === Qt.BacktabFocusReason)) ? 2 : 1



        transitions: Transition {
            ColorAnimation {
                duration: 1000
            }
        }
    }

    Text {
        id: buttonText

        anchors.centerIn: parent

        text: parent.text
        color: parent.color ? parent.color : "white"
        opacity: button.down ? 0.8 : 1
    }
}
