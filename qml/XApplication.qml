import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

XApplicationWindow {
    id: appWindowCtrl

    property bool isPortrait: height > width


    /* Global SideBar ********************************************************/

    property alias appGlobalSideBar: appGlobalSideBarLoader.item
    property alias appGlobalSideBarSource: appGlobalSideBarLoader.source
    property alias appGlobalSideBarSourceComponent: appGlobalSideBarLoader.sourceComponent

    Loader {
        id: appGlobalSideBarLoader
        active: false
        visible: true
    }

    /* End Global SideBar ****************************************************/


    /* AppNavController ******************************************************/

    property alias appNavController: appNavControllerCtrl

    function initialization() {
        console.log("XApplication > XAppNavController > initialization()")
    }

    signal appNavControllerCreated

    property alias splashViewSource: appNavControllerCtrl.splashViewSource
    property alias splashViewSourceComponent: appNavControllerCtrl.splashViewSourceComponent

    property alias viewNavigationModel: appNavControllerCtrl.viewNavigationModel

    XAppNavController {
        id: appNavControllerCtrl
        anchors.fill: parent

        Component.onCompleted: {
            appWindowCtrl.appNavControllerCreated()
        }

        function initialization() {
            appGlobalSideBarLoader.active = true

            appWindowCtrl.initialization()
        }
    }

    /* End AppNavController **************************************************/

    /* Notification **********************************************************/

    property alias appMessenger: appMessengerCtrl

    property XAction backAction: XAction {
        tooltip: qsTr("Touch again to exit")
        text: qsTr("Exit")
        onTriggered: Qt.quit()
    }

    Shortcut {
        sequences: ["Back", "Esc"]
        enabled: true
        onActivated: {
            if(appNavController.currentItem.back() === false) {
                if(appMessengerCtrl.opened && appMessengerCtrl.quitCounter == 1) {
                    backAction.triggered(appWindowCtrl)
                }
                else {
                    appMessengerCtrl.quitCounter++
                    appMessengerCtrl.show(backAction)
                }
            }
        }
    }

    XMessage {
        id: appMessengerCtrl

        property int quitCounter: 0
        onClosed: quitCounter = 0
    }

    /* End Notification ******************************************************/
}
