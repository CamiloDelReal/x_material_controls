import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

Pane {
    id: paneCtrl
    padding: 0

    height: background.implicitHeight

    z: 20

    property alias backgroundCtrl: bgItemCtrl
    property alias backgroundRadius: bgItemCtrl.radius
    property alias backgroundColor: bgItemCtrl.color

    property XAction primaryAction

    property alias title: titleLabelCtrl.text
    property alias subtitle: subtitleLabelCtrl.text

    property list<XAction> menuActions
    property int maxVisibleMenuActions: 2

    property alias overflowIcon: overflowBtnCtrl.icon.source
    property string overflowTooltip: qsTr("More actions")

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        spacing: 0

        ToolButton {
            id: btnPrimaryAction
            visible: primaryAction
            action: primaryAction ? primaryAction : null
            icon.color: primaryAction && primaryAction.customIconColor
                        ? primaryAction.icon.color
                        : paneCtrl.Material.foreground
            icon.width: primaryAction ? primaryAction.icon.width : 0
            icon.height: primaryAction ? primaryAction.icon.height : 0
            display: IconLabel.IconOnly
            ToolTip.text: btnPrimaryAction.text
            ToolTip.visible: ToolTip.text != "" && down
            ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: 0

            XTitleLabel {
                id: titleLabelCtrl
                Layout.fillWidth: true
                Layout.minimumWidth: contentWidth + leftPadding + rightPadding
                leftPadding: 15
                rightPadding: 10
            }

            XCaptionLabel {
                id: subtitleLabelCtrl
                Layout.fillWidth: true
                Layout.minimumWidth: contentWidth + leftPadding + rightPadding
                leftPadding: 15
                rightPadding: 10
                visible: text.length > 0
            }
        }

        Repeater {
            model: (!menuActions
                    ? 0
                    : (menuActions.length > Math.max(maxVisibleMenuActions, 1)
                       ? (maxVisibleMenuActions - 1)
                       : menuActions.length))

            delegate: ToolButton {
                id: actionBtnCtrl
                action: menuActions[index]
                icon.color: menuActions[index].customIconColor
                            ? menuActions[index].icon.color
                            : paneCtrl.Material.foreground
                icon.width: menuActions[index].icon.width
                icon.height: menuActions[index].icon.height
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
        id: bgItemCtrl
        implicitHeight: 48
        color: paneCtrl.Material.primary
    }
}
