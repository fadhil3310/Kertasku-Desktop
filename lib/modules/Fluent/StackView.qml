import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.StackView {
    id: control

    pushEnter: Transition {
        YAnimator {
            from: control.height
            to: 0
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    pushExit: Transition {
        PropertyAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 100

        }
    }

    popEnter: Transition {
        PropertyAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 200
        }
    }

    popExit: Transition {
        YAnimator {
            from: 0
            to: control.height
            duration: 100
            easing.type: Easing.InCubic
        }
    }

}
