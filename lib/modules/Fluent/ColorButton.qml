import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15

T.Button {
    id: control

    leftPadding: 10
    rightPadding: 10
    topPadding: 7
    bottomPadding: 7

    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitContentHeight + topPadding + bottomPadding

    property string color
    property string backgroundColor

    font.pointSize: 10

    Keys.onPressed: (event) => { if (event.key === Qt.Key_Return) clicked() }

    background: Rectangle {
        implicitWidth: 50
        implicitHeight: 30

        color: if (control.down) {
                   return "red"
               } else if(control.hovered) {
                   return "red"
               } else {
                   return "red"
               }

        radius: 4
        border.color: if (control.highlighted || control.visualFocus) {
                          return "white"
                      } else if (control.hovered) {
                          return "#12ffffff"
                      } else {
                          return "#17ffffff"
                      }

        border.width: (control.highlighted || control.visualFocus) ? 2 : 1



        Behavior on color {
            ColorAnimation { duration: 100 }
        }

    }

    contentItem: IconLabel {
        text: control.text
        font: control.font


        icon: control.icon
        mirrored: control.mirrored
        display: control.display

        color: control.color ? control.color : control.palette.buttonText
        opacity: control.down ? 0.8 : 1
    }
}
