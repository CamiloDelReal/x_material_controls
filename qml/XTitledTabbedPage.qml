import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

XPage {
    id: pageCtrl
    padding: 0

    property alias statusbar: statusbarCtrl
    property color statusbarColor: pageCtrl.Material.primary
    property int statusBarHeight: 0
    property int statusbarElevation: 0

    property alias scrollingBehavior: scrollingBehaviorCtrl

    property alias toolbar: toolbarCtrl

    property alias titlebar: titlebarCtrl

    property alias tabbar: tabbarCtrl

    property alias contentView: contentViewCtrl
    default property alias contentViewData: contentViewCtrl.contentData

    header: XToolBar {
        id: statusbarCtrl
        height: pageCtrl.statusBarHeight
        Material.background: pageCtrl.statusbarColor
        Material.elevation: pageCtrl.statusbarElevation
    }

    XScrollingBehavior {
        id: scrollingBehaviorCtrl
        type: XScrollingBehavior.ScrollType.PullBack
        order: XScrollingBehavior.ScrollOrder.BottomToTop
        topbar: toolbarCtrl
        hiddenTopBars: [titlebarCtrl, tabbarCtrl]
    }

    XToolBar {
        id: toolbarCtrl
        z: 100
        y: 0
        anchors.left: parent.left
        anchors.right: parent.right
        padding: 0

        XTitleBarNav {
            id: titlebarCtrl
            z: 99
            anchors.left: parent.left
            anchors.right: parent.right
        }

        XTabBarNav {
            id: tabbarCtrl
            z: 98
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
