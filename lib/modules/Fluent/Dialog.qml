import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 2.15 as T
import FluentHelper 1.0
//import Qt5Compat.GraphicalEffects

T.Dialog {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth, implicitHeaderWidth, contentWidth) + leftPadding + rightPadding
  implicitHeight: implicitBackgroundHeight + topPadding + bottomPadding + contentHeight + implicitHeaderHeight + implicitFooterHeight

  leftPadding: 20
  rightPadding: 20
  bottomPadding: 20

  onAboutToShow: {
    scaleInAnimation.start()
    //opacityInAnimation.start()
  }

  background: Rectangle {
    implicitWidth: 250
    color: "#2b2b2b" //FluentHelper.isLight ? "#FEFEFE" : "#000000"
    radius: 8
    border.color: "#20ffffff"
    border.width: 1
  }

  header: Label {
    text: control.title
    font.bold: true
    font.pointSize: 16
    padding: 20

  }

  footer: DialogButtonBox {
    visible: true
    background: Rectangle {
      color: "#202020"
    }

    delegate: Button {}

    spacing: 8

    padding: 20
  }

  T.Overlay.modal: Rectangle {
    color: "#50000000"
  }

  T.Overlay.modeless: Rectangle {
    color: "#50000000"
  }

  ParallelAnimation {
    id: scaleInAnimation
    NumberAnimation {
      target: control
      property: "scale"
      duration: 200
      easing.type: Easing.OutCubic
      from: 1.05
      to: 1
    }
    /*OpacityAnimator {
      //target:
      from: 0
      to: 1
      duration: 200
      //easing.type: Easing.OutCubic
      running: false
    }*/


  }


}
