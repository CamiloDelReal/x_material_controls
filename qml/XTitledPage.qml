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

    property alias contentView: contentViewCtrl
    default property alias contentViewData: contentViewCtrl.contentData

    header: XToolBar {
        id: statusbarCtrl
        visible: pageCtrl.statusBarHeight > 0
        height: pageCtrl.statusBarHeight
        Material.background: pageCtrl.statusbarColor
        Material.elevation: pageCtrl.statusbarElevation
    }

    XScrollingBehavior {
        id: scrollingBehaviorCtrl
        type: XScrollingBehavior.ScrollType.PullBack
        order: XScrollingBehavior.ScrollOrder.BottomToTop
        topbar: toolbarCtrl
        hiddenTopBars: [titlebarCtrl]
    }

    XToolBar {
        id: toolbarCtrl
        anchors.left: parent.left
        anchors.right: parent.right
        height: titlebarCtrl.implicitHeight
        y: 0
        z: 100
        topInset: topMargin
        topPadding: topMargin
        rightInset: rightMargin
        rightPadding: rightMargin
        bottomInset: bottomMargin
        bottomPadding: bottomMargin
        leftInset: leftMargin
        leftPadding: leftMargin

        XTitleBarNav {
            id: titlebarCtrl
            anchors.left: parent.left
            anchors.right: parent.right
            y: 0
            backgroundCtrl.radius: toolbarCtrl.backgroundCtrl.radius
            backgroundCtrl.color: toolbarCtrl.backgroundCtrl.color
            z: 99
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

        // UI cheat for delete the white flash over statusbar
        // when change the page using fade in/out transition
        Rectangle {
            width: parent.width
            height: pageCtrl.statusBarHeight
            color: pageCtrl.statusbarColor
        }
    }
}
