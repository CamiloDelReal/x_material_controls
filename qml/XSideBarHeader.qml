import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Material.impl 2.14
import QtQuick.Layouts 1.14

Pane {
    id: headerCtrl

    property int statusBarHeight: 0
    property int baseHeight: 132

    topPadding: headerCtrl.statusBarHeight + 10
    leftPadding: 10
    bottomPadding: Material.elevation * 2
    rightPadding: 10
    width: parent.width
    height: headerCtrl.statusBarHeight + headerCtrl.baseHeight + Material.elevation * 2
    Material.elevation: 4
    clip: true
    bottomInset: Material.elevation * 2
    Material.foreground: headerCtrl.Material.primaryTextColor

    property alias title: titleLabel.text

    property list<XAction> menuActions
    property int maxVisibleMenuActions: 2

    property alias overflowIcon: overflowBtnCtrl.icon.source
    property string overflowTooltip: qsTr("More actions")

    property alias backgroundColor: bgItem.color
    property alias backgroundImage: bgImage.source

    XTitleLabel {
        id: titleLabel
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.top: parent.top
        anchors.topMargin: 12
    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        Repeater {
            model: (!menuActions
                    ? 0
                    : (menuActions.length > Math.max(maxVisibleMenuActions, 1)
                       ? (maxVisibleMenuActions - 1)
                       : menuActions.length))

            delegate: ToolButton {
                id: actionBtnCtrl
                action: menuActions[index]
                display: IconLabel.IconOnly
                ToolTip.text: menuActions[index].text
                ToolTip.visible: ToolTip.text != "" && down
                ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
            }
        }

        ToolButton {
            id: overflowBtnCtrl
            visible: menuActions.length > Math.max(maxVisibleMenuActions, 1)
            onClicked: overflowMenuCtrl.open()
            icon.source: "qrc:/img/default-dots-vertical.svg"
            ToolTip.text: overflowTooltip
            ToolTip.visible: ToolTip.text != "" && down
            ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval

            XMenu {
                id: overflowMenuCtrl
                modal: true
                dim: false
                x: overflowBtnCtrl.width - width - 10
                y: 10

                Instantiator {
                    model: (!menuActions
                            ? 0
                            : (menuActions.length > Math.max(maxVisibleMenuActions, 1)
                               ? (menuActions.length - maxVisibleMenuActions + 1)
                               : 0))
                    delegate: XMenuItem {
                        id: menuitemCtrl
                        action: menuActions[index + maxVisibleMenuActions - 1]
                    }
                    onObjectAdded: overflowMenuCtrl.addItem(object)
                    onObjectRemoved: overflowMenuCtrl.removeItem(index)
                }
            }
        }
    }

    background: Rectangle {
        id: bgItem
        color: headerCtrl.Material.primary

        Image {
            id: bgImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            visible: source
        }

        layer.enabled: headerCtrl.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: headerCtrl.Material.elevation
            fullWidth: true
        }
    }
}
