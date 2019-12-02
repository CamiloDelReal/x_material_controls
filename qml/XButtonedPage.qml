import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

XPage {
    id: pageCtrl
    padding: 0

    property alias statusbar: statusbarCtrl
    property color statusbarColor: pageCtrl.Material.primary
    property int statusBarHeight: 0
    property int statusbarElevation: 4

    property alias buttonbar: buttonbarCtrl

    property alias contentView: contentViewCtrl
    default property alias contentViewData: contentViewCtrl.contentData

    header: XToolBar {
        id: statusbarCtrl
        height: pageCtrl.statusBarHeight
        Material.background: pageCtrl.statusbarColor
        Material.elevation: pageCtrl.statusbarElevation
    }

    XPane {
        id: contentViewCtrl
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.top: parent.top
        padding: 0
    }

    footer: XButtonBarNav {
        id: buttonbarCtrl
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
