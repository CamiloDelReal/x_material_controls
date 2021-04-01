import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

XPage {
    id: pageCtrl
    padding: 0

    property alias statusbar: statusbarCtrl
    property color statusbarColor: pageCtrl.Material.primary
    property int statusbarHeight: 0
    property int statusbarElevation: 0

    property alias scrollingBehavior: scrollingBehaviorCtrl

    property alias toolbar: toolbarCtrl

    property alias titlebar: titlebarCtrl

    property alias buttonbar: buttonbarCtrl

    property alias contentView: contentViewCtrl
    default property alias contentViewData: contentViewCtrl.contentData

    header: XToolBar {
        id: statusbarCtrl
        visible: pageCtrl.statusbarHeight > 0
        height: pageCtrl.statusbarHeight
        Material.background: pageCtrl.statusbarColor
        Material.elevation: pageCtrl.statusbarElevation
    }

    XScrollingBehavior {
        id: scrollingBehaviorCtrl
        type: XScrollingBehavior.ScrollType.PullBack
        order: XScrollingBehavior.ScrollOrder.BottomToTop
        hiddenTopBars: [titlebarCtrl]
        topbar: toolbarCtrl
    }

    XToolBar {
        id: toolbarCtrl
        z: 100
        y: 0
        anchors.left: parent.left
        anchors.right: parent.right

        XTitleBarNav {
            id: titlebarCtrl
            z: 99
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }

    XPane {
        id: contentViewCtrl
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: scrollingBehaviorCtrl.topbar && scrollingBehaviorCtrl.flickable
                           ? 0
                           : scrollingBehaviorCtrl.topbar.height
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
            height: pageCtrl.statusbarHeight
            color: pageCtrl.statusbarColor
        }
    }
}
