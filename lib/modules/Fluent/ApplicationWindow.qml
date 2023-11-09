import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import FluentHelper 1.0
import QtQuick.Window 2.15

T.ApplicationWindow {
    id: control

    palette {
        text: (FluentHelper.isLight) ? palette.text : "white"
        windowText: (FluentHelper.isLight) ? palette.windowText : "white"
        buttonText: palette.windowText
    }

    //palette.text: "white"
    //palette.windowText: "white"

    /*color: {
        if(FluentHelper.micaEnabled) {
            micaEnabler.window = control
            return "transparent"
        } else return "red" //Fluent.isLight ? "white"
    }*/

    MicaEnabler {
        fallbackColorLight: "white"
        fallbackColorDark: "black"
        window: control
    }
    /*Component.onCompleted: {
        console.log("completed")
        //color: "transparent"
        //micaEnabler.window = control
        //
    }*/

    //Fluent.mode: 2
     //Fluent.isLight ? "white" : "black" //FluentItem.windowColor

    /*Timer {
        interval: 2000; running: true; repeat: false
        onTriggered:{
            console.log(control.color)
            control.color = "red"
            //kedua.start()
        }
    }

    Timer {
        id: kedua
        interval: 2000; repeat: false
        onTriggered:{
            console.log(control.color)
            control.color = "transparent"
        }
    }*/

}
