import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import FluentHelper 1.0
import FluentIcons 1.0
import Kertasku 1.0

RowLayout {
  ColumnLayout {
    Layout.alignment: Qt.AlignLeft
    Layout.maximumWidth: 200
    Layout.fillHeight: true

    RowLayout {
      Layout.margins: 8

      Label {
        text: qsTr("Mindmap")
        font.bold: true
        font.pointSize: 12
        font.family: "Cairo"
      }
    }

    ListView {
      Layout.fillWidth: true
      Layout.fillHeight: true
      clip: true

      //boundsBehavior: Flickable.StopAtBounds

      model: 100
      delegate: RowLayout {
        FluentIcon {
          iconName: "CaretUp"
          color: "#FFFFFF"
          width: 30
        }
        Label {
          text: "Catatan"
        }
      }

      ScrollBar.vertical: ScrollBar {}
    }
  }

  Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "#05FFFFFF"
  }
}
