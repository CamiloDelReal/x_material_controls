import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

XPage {
    id: pageCtrl
    padding: 0

    property alias statusbar: statusbarCtrl
    property color statusbarColor: pageCtrl.Material.primary
    property int statusBarHeight: 0
    property int statusbarElevation: 4

    header: XToolBar {
        id: statusbarCtrl
        visible: pageCtrl.statusBarHeight > 0
        height: pageCtrl.statusBarHeight
        Material.background: pageCtrl.statusbarColor
        Material.elevation: pageCtrl.statusbarElevation
    }

    background: Rectangle {
        color: pageCtrl.Material.backgroundColor

        // UI cheat for delete de white flash over statusbar
        // when change the page using fade in/out transition
        Rectangle {
            width: parent.width
            height: pageCtrl.statusBarHeight
            color: pageCtrl.statusbarColor
        }
    }
}
