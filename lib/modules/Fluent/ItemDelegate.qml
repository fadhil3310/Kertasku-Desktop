import QtQuick 2.0
import QtQuick.Templates 2.15 as T

T.ItemDelegate {
  id: control

  implicitWidth: 100
  implicitHeight: 40

  contentItem: Text {
    text: control.text
    font: control.font
  }

  background: Rectangle {
    width: control.width
    height: control.height

    //radius: 6

    color: if (control.down) {
             return "#05ffffff"
         } else if(control.hovered) {
             return "#08ffffff"
         } else {
             return "transparent"
         }
  }
}
