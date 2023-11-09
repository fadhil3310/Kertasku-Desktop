import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
  id: root

  color: "black"

  signal save(id: int, content: string)

  signal getPageSize(callback: int)

  signal requestPage(bookId: int, callback: QtObject)

  function openNote(bookId: int) {

  }

  function getPage(content: string) {
    console.log(content)
  }

  Label {
      text: "abc"
  }

  TextEdit {
    id: content

    anchors.fill: parent
  }

  Button {
    text: "Save"

    onClicked: {
      //root.save(content.text)

      root.requestPage(0, getPage)
    }
  }

}
