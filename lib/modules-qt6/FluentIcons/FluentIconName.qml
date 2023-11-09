import QtQuick 2.15

pragma Singleton
QtObject {
    readonly property string path: "$$PWD/"

    readonly property string caretUp: path + "CaretUp.svg"
    readonly property string caretDown: path + "CaretDown.svg"
}
