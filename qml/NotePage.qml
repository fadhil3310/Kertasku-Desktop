import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import FluentHelper 1.0
import FluentIcons 1.0
import Kertasku 1.0
import Fluent 1.0
//import Qt5Compat.GraphicalEffects

Item {
  id: root

  Item {
    id: bookListPane
    /*Layout.alignment: Qt.AlignLeft
    Layout.maximumWidth: 200
    Layout.fillHeight: true*/
    anchors {
      top: root.top
      left: root.left
      bottom: root.bottom

    }
    width: 200

    RowLayout {
      id: bookListPaneHeader
      anchors {
        top: bookListPane.top
        left: bookListPane.left
        right: bookListPane.right
        margins: 8
      }

      Layout.margins: 8

      Label {
        Layout.fillWidth: true
        text: qsTr("Notebook")
        font.bold: true
        font.pointSize: 12
        font.family: "Cairo"
      }

      AppBarButton {
        text: qsTr("Create")
        iconName: "Add"
        onClicked: {
          createBookDialog.open()
        }
      }
    }

    /*CreateBookDialog {
      id: createBookDialog
    }*/
    CreateBookDialog {
      id: createBookDialog
      onAccepted: {
        if (!noteBackend.createBook(bookTitle, {"color": selectedColor}, "local")) {
          console.log("Failed")
        }
      }
    }

    NoteBackend {
      id: noteBackend
    }

    ListView {
      id: bookList
      /*Layout.fillWidth: true
      Layout.fillHeight: true*/
      anchors {
        top: bookListPaneHeader.bottom
        left: bookListPane.left
        right: bookListPane.right
        bottom: bookListPane.bottom
        topMargin: 8
      }

      model: noteBackend.bookListModel

      focus: true
      clip: true

      boundsBehavior: Flickable.StopAtBounds

      highlightMoveDuration: 150
      highlightResizeDuration: 0

      highlight: Rectangle {
        color: "#15ffffff"
        //radius: 6
      }

      delegate: ItemDelegate {
        width: bookList.width

        onClicked: if (noteBackend.selectedBook !== index) {
                     noteBackend.selectBook(index)
                     bookList.currentIndex = index
                   }

        onHoveredChanged: if (hovered) {
                            bookFrontCover.transform[0].angle = 50
                          } else {
                            bookFrontCover.transform[0].angle = 0
                          }

        RowLayout {
          anchors.fill: parent

          Item {
            width: 30
            height: 30

            Canvas {
              id: bookBackCover
              width: 30
              height: 30
              antialiasing: true

              Component.onCompleted: {
                loadImage("qrc:///asset/img/side_book.svg")
              }

              onPaint: {
                let ctx = getContext('2d')
                ctx.fillStyle = Qt.hsla(0, 0.7, 0.67, 0.4)
                ctx.beginPath()
                ctx.moveTo(8, 2)
                ctx.lineTo(26, 2)
                ctx.arcTo(28, 3, 28, 6, 3)
                ctx.lineTo(28, 26)
                ctx.arcTo(28, 28, 26, 28, 3)
                ctx.lineTo(8, 28)
                ctx.lineTo(8,3)
                ctx.closePath()
                ctx.fill()


                ctx.drawImage("qrc:///asset/img/side_book.svg", 6, 2)
              }
            }

            Canvas {
              id: bookContentPreview
              width: 30
              height: 30
              antialiasing: true

              property int count: 0
              property string content: ""

              Component.onCompleted: {
                noteBackend.createBookThumbnail(index, (count, content) => {
                                               this.count = count
                                               this.content = content
                                               requestPaint()
                                             })
              }

              onPaint: {
                if (count === 0)
                  return
                else {
                  let ctx = getContext('2d')

                  if (count > 1) {
                    let gradient = ctx.createLinearGradient(25, 0, 28, 0)
                    gradient.addColorStop(0.0, '#a6a6a6')
                    gradient.addColorStop(1.0, '#f2f2f2')
                    ctx.fillStyle = gradient
                    ctx.beginPath()
                    ctx.moveTo(23, 2)
                    ctx.lineTo(25, 2)
                    ctx.arcTo(28, 3, 28, 6, 3)
                    ctx.lineTo(28, 26)
                    ctx.arcTo(28, 28, 25, 28, 3)
                    ctx.lineTo(23, 28)
                    ctx.lineTo(23, 2)
                    ctx.closePath()
                    ctx.fill()
                    ctx.restore()
                  }

                  ctx.fillStyle = 'white'
                  ctx.beginPath()
                  ctx.moveTo(8, 2)
                  ctx.lineTo(23, 2)
                  ctx.arcTo(25, 3, 25, 6, 3)
                  ctx.lineTo(25, 26)
                  ctx.arcTo(25, 28, 23, 28, 3)
                  ctx.lineTo(8, 28)
                  ctx.lineTo(8, 2)
                  ctx.closePath()
                  ctx.fill()
                  ctx.fillStyle = 'gray'
                  ctx.font = "3px sans-serif"
                  ctx.fillText("Title", 10, 7)
                  ctx.font = "2px sans-serif"
                  ctx.fillText(content, 10, 10)
                }
              }
            }

            Canvas {
              id: bookFrontCover
              width: 30
              height: 30
              antialiasing: true

              onPaint: {
                let ctx = bookFrontCover.getContext('2d')
                ctx.fillStyle = Qt.hsla(0, 0.7, 0.67, 0.6) //'hsla(0, 100%, 50%, 0.25)'
                ctx.beginPath()
                ctx.moveTo(6, 2)
                ctx.lineTo(23, 2)

                ctx.arcTo(25, 3, 25, 6, 3)
                ctx.lineTo(25, 26)
                ctx.arcTo(25, 28, 23, 28, 3)
                ctx.lineTo(6, 28)
                ctx.lineTo(6, 3)
                ctx.closePath()
                ctx.fill()
              }

              transform: Rotation {
                origin.x: 5
                origin.y: 5
                axis { x: 0; y: 1; z: 0 }
                angle: 0

                Behavior on angle {
                  NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                }
              }
            }
          }

          Text {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 2
            color: palette.windowText

            text: title
            verticalAlignment: Text.AlignVCenter
          }
        }
      }

      ScrollBar.vertical: ScrollBar { }
    }

    MouseArea {
      id: bookListPaneResizer
      anchors {
        top: bookListPane.top
        right: bookListPane.right
        bottom: bookListPane.bottom
      }

      width: 6

      cursorShape: Qt.SizeHorCursor

      onPressed: console.log("pressed")
      onReleased: console.log("released")
      onPositionChanged: (ev) => {
                           let newWidth = bookListPane.x + bookListPane.width + ev.x
                           if (newWidth > 150 && newWidth < 300)
                            bookListPane.width = newWidth
                         }
    }
  }

  Rectangle {
    id: noteListPane

    /*Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.margins: 0*/
    anchors {
      top: root.top
      left: bookListPane.right
      bottom: root.bottom
      right: root.right
    }
    color: "#05FFFFFF"

    GridView {
      id: noteList
      anchors.fill: parent
      anchors.margins: 8

      model: noteBackend.noteListModel
      displayMarginBeginning: 4

      clip: true

      cellWidth: width / (Math.ceil(width / 250))

      highlight: Rectangle {
        color:  "#20ffffff"
        radius: 8
      }

      populate: Transition {
        NumberAnimation {
          properties: "x,y"
          from: 0
          duration: 200
          easing.type: Easing.OutCubic
        }
      }

      header: Label {
        width: 50
        height: 50
        text: "abc"
      }

      delegate: ItemDelegate {
        width: noteList.cellWidth
        height: noteList.cellHeight

        background: Rectangle {
          implicitWidth: parent.width
          implicitHeight: 50
          border {
            color: 'gray'
            width: 1
          }
          radius: 8
          color: 'transparent'
        }

        ColumnLayout {
          anchors { fill: parent; margins: 4 }

          Label {
            height: 30
            Layout.fillWidth: true
            text: title
            font.bold: true
            font.pointSize: 14

          }
          Label {
            Layout.fillWidth: true
            Layout.fillHeight: true
            wrapMode: Text.WordWrap
            text: content
            clip: true
          }
        }
      }


      ScrollBar.vertical: ScrollBar {}
    }

    Button {
      anchors {
        bottom: parent.bottom
        right: parent.right
      }

      text: "+"

      onClicked: {
        noteEditor.showPane()
      }
    }
  }

  NoteEditor {
    id: noteEditor
    visible: false

    anchors {
      left: bookListPane.right
      top: parent.top
      right: parent.right
      bottom: parent.bottom
    }

    function showPane() {
      this.visible = true
      noteEditorOpenAnimation.start()
    }

    onSave: (id, content) => {
              if (id === -1) {
                if (content === "") return
              }

              noteBackend.writeNote(id, content)
            }

    onRequestPage: (id, callback) => {
                     callback("abc")
                   }

    NumberAnimation on anchors.leftMargin {
      id: noteEditorOpenAnimation
      duration: 400
      easing.type: Easing.OutQuad
      from: 400
      to: 0
    }
  }
}

