import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    RowLayout {
        Button {
            //icon.name: "places/scalable/folder"
        }
    }

    /*Rectangle {
        width: 200
        height: 200
        color: "red"


        RotationAnimation on rotation {
            loops: Animation.Infinite
            duration: 200
            from: 0
            to: 180

        }

    }*/

    /*StackView {
        padding: 20

        Button {
            text: "Abcdefg"
        }

        Text {
            text: "Abcdefg"
            font.pointSize: 20
            font.bold: true
            //font.italic: true

        }

    }*/

    ListModel {
        id: listModel
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abc"
        }
        ListElement {
            name: "abcasdasd ajsd as dnasdnajsndsakddanhdsadjnasdnasjndkajsnd"
        }
        ListElement {
            name: "abc"
        }
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: listView
            focus: true
            clip: true

            Layout.fillWidth: true
            Layout.fillHeight: true

            /*transform: Scale {
                yScale: if(listView.verticalOvershoot > 0) return yScale + listView.verticalOvershoot
            }*/

            model: listModel
            delegate: Text {
                text: name
                padding: 8
            }

            Keys.onUpPressed: vScrollBar.decrease()
            Keys.onDownPressed: vScrollBar.increase()

            ScrollBar.vertical: ScrollBar {
                id: vScrollBar
                policy: ScrollBar.AlwaysOn
            }
        }
        Button {
            id: button1
            text: "abc"

            onClicked: {
                console.log("1 clicked")
            }
        }

        Button {
            id: button2
            text: "sadsandsadsandasndiasundiasudnaisudniuasndiasudn"

            onClicked: {
                console.log("2 clicked")
            }
        }
    }
}
