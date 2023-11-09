import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Templates 2.15 as T
import FluentIcons 1.0

T.Button {
  id: control

  leftPadding: 8
  rightPadding: 8
  topPadding: 8
  bottomPadding: 8

  implicitWidth: implicitContentWidth + leftPadding + rightPadding
  implicitHeight: implicitContentHeight + topPadding + bottomPadding

  property string color
  property string iconName: ""
  property bool isCompact: false

  Keys.onPressed: (event) => { if (event.key === Qt.Key_Return) clicked() }

  background: Rectangle {
    implicitWidth: 50
    implicitHeight: 30

    color: if (control.down) {
             return "#08ffffff"
           } else if(control.hovered) {
             return "#15ffffff"
           } else {
             return "#00000000"
           }

    radius: 4
    border.color: if (control.highlighted || control.visualFocus) {
                      return "white"
                  } else {
                      return "#00000000"
                  }

    border.width: 2

    Behavior on color {
      ColorAnimation { duration: 100 }
    }

  }



  contentItem: RowLayout {
    opacity: control.down ? 0.8 : 1

    FluentIcon {
      id: fluentIcon
      iconName: control.iconName
      iconSize: 20
    }

    Text {
        text: control.text
        color: control.color ? control.color : "white"

        visible: isCompact ? false : true
    }
  }
}
