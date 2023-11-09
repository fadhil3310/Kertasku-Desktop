import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.AbstractButton {
    Keys.onPressed: (event) => {  if (event.key === Qt.Key_Return) clicked() }
}
