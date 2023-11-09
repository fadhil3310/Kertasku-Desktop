import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import FluentHelper 1.0

T.TextField {
  id: control

  implicitWidth: implicitBackgroundWidth + leftPadding + rightPadding
  implicitHeight: implicitBackgroundHeight + topPadding + bottomPadding + contentHeight

  color: palette.text

  topPadding: 6
  leftPadding: 6
  bottomPadding: 6
  rightPadding: 6

  background: Rectangle {
    id: controlBackground

    implicitWidth: 120
    implicitHeight: 2

    color: "#20ffffff"
    border {
      width: 1
      color: "transparent"
    }
    radius: 4
    clip: true

    Rectangle {
      anchors {
        left: parent.left
        bottom: parent.bottom
        right: parent.right
      }
      width: parent.width
      height: 2
      color: "green"
    }
  }

  states: [
    State {
      name: "focused"
      when: control.focus
      PropertyChanges {
        target: controlBackground
        border.color: "#20ffffff"
        color: "20000000"
      }
    }

  ]
}
