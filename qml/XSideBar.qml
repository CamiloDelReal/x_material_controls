import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

Drawer {
    id: drawerCtrl
    width: Math.min(parent.width, parent.height) * 0.75
    height: parent.height
    edge: Qt.LeftEdge
    parent: ApplicationWindow.overlay

    property alias header: headerCtrl.contentChildren

    property alias scrollingBehavior: scrollingBehaviorCtrl

    property alias contentView: contentViewCtrl
    default property alias contentViewData: contentViewCtrl.contentData

    Overlay.modal: Rectangle {
        color: "#99303030"
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    Overlay.modeless: Rectangle {
        color: "#99303030"
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    XScrollingBehavior {
        id: scrollingBehaviorCtrl
        order: XScrollingBehavior.ScrollOrder.TopToBottom
        type: XScrollingBehavior.ScrollType.Inline
        topbar: headerCtrl
    }

    XToolBar {
        id: headerCtrl
        anchors.left: parent.left
        anchors.right: parent.right
        padding: 0
        z: 99
        background: null
        onContentChildrenChanged: {
            if(contentChildren.length > 0)
                scrollingBehaviorCtrl.hiddenTopBars = [headerCtrl.contentChildren[0]]
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
}
