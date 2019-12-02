import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Drawer {
    id: drawerCtrl
    width: Math.min(parent.width, parent.height) * 0.75
    height: parent.height
    edge: Qt.LeftEdge
    parent: ApplicationWindow.overlay

    Overlay.modal: Rectangle {
        color: "#99303030"
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    Overlay.modeless: Rectangle {
        color: "#99303030"
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    XScrollingBehavior {
        id: scrollingBehavior
        order: XScrollingBehavior.ScrollOrder.TopToBottom
        type: XScrollingBehavior.ScrollType.Inline
        topbar: headerCtrl
        flickable: linksListCtrl
        scrollIndicator: linksListScrollCtrl
    }

    property alias header: headerCtrl.contentChildren

    XToolBar {
        id: headerCtrl
        anchors.left: parent.left
        anchors.right: parent.right
        padding: 0
        z: 99
        background: null
        onContentChildrenChanged: {
            if(contentChildren.length > 0)
                scrollingBehavior.hiddenTopBars = [headerCtrl.contentChildren[0]]
        }
    }

    property list<XAction> linkActions

    property int currentIndex: -1

    ListView {
        id: linksListCtrl
        anchors.fill: parent
        ScrollIndicator.vertical: ScrollIndicator {
            id: linksListScrollCtrl
        }
        headerPositioning: ListView.InlineHeader
        footer: Item {
            width: parent.width
            height: 15
        }
        currentIndex: drawerCtrl.currentIndex  // Don't be reading the first value at init
        model: linkActions ? linkActions : 0
        delegate: XItemDelegate {
            width: parent.width
            autoExclusive: modelData.checkable
            action: modelData
            highlighted: checked
            leftPadding: 18
            rightPadding: 16
            spacing: 30
            Component.onCompleted: {
                if(checked)
                    drawerCtrl.currentIndex = index
            }
            onClicked: {
                if(checkable) {
                    modelData.checked = true
                    drawerCtrl.currentIndex = index
                }
                drawerCtrl.close()
            }
        }
        section.property: "category"
        section.criteria: ViewSection.FullString
        section.labelPositioning: ViewSection.InlineLabels
        section.delegate: XListGroupHeader {
            text: section != " " ? section : ""
            width: parent.width
            label.lineHeight: text.length === 0 ? 0 : 1.0
            textColor: Material.secondaryTextColor
            dividerVisible: false
            textTopPadding: text.length === 0 ? 1 : 10
            textBottomPadding: text.length === 0 ? 1 : 10
        }
    }
}
