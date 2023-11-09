import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
//import Qt5Compat.GraphicalEffects
import Kertasku 1.0

Dialog {
  id: createBookDialog
  x: (parent.width - width) / 2
  y: (parent.height - height) / 2
  parent: Overlay.overlay

  title: qsTr("Create new book")
  modal: true
  standardButtons: Dialog.Yes | Dialog.Cancel
  focus: true

  property string bookTitle: ""
  property variant selectedColor: [0, 0.7, 0.67]

  onOpened: {
    titleTextField.focus = true
  }
  onAccepted: {
    bookTitle = titleTextField.text
  }

  component BookCoverButton: Button {
    id: control
    implicitWidth: 25
    implicitHeight: 25

    property string mode
    property variant color: [0, 0, 0]
    property string imageUrl: ""

    onClicked: {
      selectedColor = color
      bookThumbnail.color = color
      bookThumbnail.requestPaint()
      bookThumbnailColorAnimation.start()
    }

    background: Item {
      Rectangle {
        anchors.fill: parent
        color: Qt.hsla(control.color[0], control.color[1], control.color[2], 1)
        visible: control.mode == "color"
        radius: 10
      }
      Image {
        source: control.imageUrl
        visible: control.mode == "image"
      }
    }

    states: [
      State {
        when: control.pressed
        PropertyChanges {
          target: control
          scale: 0.9
        }
        PropertyChanges {
          target: control
          y: -2
        }
      },
      State {
        when: control.hovered
        PropertyChanges {
          target: control
          y: -2
        }
      },
      State {
        when: control.visualFocus
        PropertyChanges {
          target: control
          y: -2
        }
        PropertyChanges {
          target: control
          opacity: 0.5
        }
      }

    ]

    transitions: Transition {
        NumberAnimation {
            properties: "y,scale,opacity"
            duration: 50
        }
    }

  }

  ColumnLayout {
    anchors.fill: parent
    RowLayout {
      BookThumbnail {
        id: bookThumbnail
        width: 45
        height: 45
        SequentialAnimation {
          id: bookThumbnailColorAnimation
          ParallelAnimation {
            NumberAnimation {
              target: bookThumbnail
              property: "y"
              to: 10
              duration: 100
              //easing.type: Easing.InOutQuad
            }
            NumberAnimation {
              target: bookThumbnail
              property: "scale"
              to: 0.9
              duration: 100
              easing.type: Easing.OutBack
            }
          }
          ParallelAnimation {
            NumberAnimation {
              target: bookThumbnail
              property: "y"
              to: 0
              duration: 150
              //easing.type: Easing.InOutQuad
            }
            NumberAnimation {
              target: bookThumbnail
              property: "scale"
              to: 1
              duration: 150
              easing.type: Easing.OutBack
            }
          }
        }
      }
      ColumnLayout {
        Layout.fillWidth: true
        Label {
          text: qsTr("Book cover:")
        }
        RowLayout {
          BookCoverButton { mode: "color"; color: [0, 0.7, 0.67] }
          BookCoverButton { mode: "color"; color: [0.34, 0.38, 0.64] }
          BookCoverButton { mode: "color"; color: [0.49, 0.42, 0.51] }
          BookCoverButton { mode: "color"; color: [0.15, 1, 0.73] }
          /*Button {
            color: "green"
            text: "Green"
          }
          Button {
            color: "blue"
            text: "Blue"
          }*/
        }
      }
    }
    RowLayout {
      Layout.fillWidth: true
      Label {
        Layout.fillHeight: true
        verticalAlignment: Text.AlignVCenter
        text: qsTr("Title:")
        Layout.rightMargin: 4
      }
      TextField {
        id: titleTextField
        Layout.fillWidth: true
      }

    }
    Label {
      text: "Advanced options"
    }
    Button {
      //text: "abc"
    }
  }
}
