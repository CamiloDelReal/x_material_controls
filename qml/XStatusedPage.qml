import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

XPage {
    id: pageCtrl
    padding: 0

    property alias statusbar: statusbarCtrl
    property color statusbarColor: pageCtrl.Material.primary
    property int statusbarHeight: 0
    property int statusbarElevation: 4

    header: XToolBar {
        id: statusbarCtrl
        visible: pageCtrl.statusbarHeight > 0
        height: pageCtrl.statusbarHeight
        Material.background: pageCtrl.statusbarColor
        Material.elevation: pageCtrl.statusbarElevation
    }

    background: Rectangle {
        color: pageCtrl.Material.backgroundColor

        // UI cheat for delete de white flash over statusbar
        // when change the page using fade in/out transition
        Rectangle {
            width: parent.width
            height: pageCtrl.statusbarHeight
            color: pageCtrl.statusbarColor
        }
    }
}
