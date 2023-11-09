import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import FluentHelper 1.0
import FluentIcons 1.0
import Kertasku 1.0
//import "test-supabase.js" as TestSupabase
//import "../supabase-client/supabase-js.js" as SupabaseClient
import "../supabase-client/supabase-js/abc123.js" as SupabaseJavascript

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Kertasku")

    property int selectedItem: 0
    property bool isMindmapPageLoaded: false


    function create() {

      //SupabaseJavascript.createClient()

      //const { createCient } = SupabaseClient.supabase
      //const instance = createClient('abc', 'abc');
    }


    Component.onCompleted: {
      create()
    }

    //palette.buttonText: "#eeeeee"

    RowLayout {
        anchors.fill: parent

        //ScrollView {
            // TODO: Fix

            //Layout.fillHeight: true

        ColumnLayout {
            Layout.alignment: Qt.AlignTop
            Layout.margins: 4

            NavBarButton {
                id: notebookBarButton
                iconName: "Notebook"
                text: qsTr("Notes")
                selected: true
                onClicked: {
                    if (stackLayout.currentIndex !== 0) {
                        //createClient()
                        console.log("clicked")
                        /*notePage.visible = true
                        mindmapPage.visible = false
                        notePage.state = "Entered"
                        mindmapPage.state = "Closed"*/
                        stackLayout.currentIndex = 0
                        //notePageAnimation.start()
                        stackLayoutYAnimator.start()
                        stackLayoutOpacityAnimator.start()
                        //selectedItem = 0
                        this.selected = true
                        mindmapBarButton.selected = false
                    }
                }
                KeyNavigation.up: mindmapBarButton
                KeyNavigation.down: mindmapBarButton
                KeyNavigation.tab: switch(stackLayout.currentIndex) {
                                   case 0:
                                       return notePage.children[0].children[1]
                                   case 1:
                                       return taskPage
                                   }
            }
            NavBarButton {
                id: mindmapBarButton
                iconName: "Notebook"
                text: qsTr("Task")
                onClicked: {
                    if (stackLayout.currentIndex !== 1) {
                        console.log(window.palette.windowText);
                        console.log("clicked")
                        /*if (!isMindmapPageLoaded) {
                            mindmapPage.source = "MindmapPage.qml"
                            isMindmapPageLoaded = true
                        }*/
                        /*notePage.visible = false
                        mindmapPage.visible = true
                        notePage.state = "Closed"
                        mindmapPage.state = "Entered"*/
                        stackLayout.currentIndex = 1
                        stackLayoutYAnimator.start()
                        stackLayoutOpacityAnimator.start()
                        //selectedItem = 1
                        this.selected = true
                        notebookBarButton.selected = false
                    }
                }
                KeyNavigation.up: notebookBarButton
                KeyNavigation.down: notebookBarButton
            }
        }

        //}


        NavigationViewBackground {
            id: navigationViewBackground
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "#08FFFFFF"

            StackLayout {
                id: stackLayout
                anchors.fill: parent
                transform: Translate { id: notePageTranslate; y: 0 }

                YAnimator {
                    id: stackLayoutYAnimator
                    target: stackLayout
                    from: height
                    to: 0
                    duration: 300
                    easing.type: Easing.OutCubic
                    running: false
                }
                OpacityAnimator {
                    id: stackLayoutOpacityAnimator
                    target: stackLayout
                    from: 0
                    to: 1
                    duration: 200
                    //easing.type: Easing.OutCubic
                    running: false
                }


                /*NumberAnimation {
                    id: notePageAnimation
                    target: notePageTranslate
                    property: "y"
                    duration: 300
                    easing.type: Easing.OutCubic
                    running: false
                    from: height
                    to: 0
                }*/

                NotePage {
                    id: notePage
                }
                TaskPage {
                    id: taskPage
                }
            }

        }
    }
}
