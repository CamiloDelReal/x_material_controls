import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.12

Pane {
    id: paneCtrl
    padding: 0
    Material.elevation: 4
    z: 20

    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             tabbarCtrl.implicitHeight)

    property bool highlightVisible: false
    property alias backgroundColor: bgItemCtrl.color

    property XAction primaryAction

    property alias title: titleLabelCtrl.text
    property alias subtitle: subtitleLabelCtrl.text

    property list<XAction> buttonActions
    property int buttonsLeftMargin: 8
    property int buttonsRightMargin: 8

    property list<XAction> menuActions
    property int maxVisibleMenuActions: 2

    property alias overflowIcon: overflowBtnCtrl.icon.source
    property string overflowTooltip: qsTr("More actions")

    RowLayout {
        id: primaryActionLayoutCtrl
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: menuActions && menuActions.length > 0 ? true : false
        spacing: 0

        ToolButton {
            id: btnPrimaryAction
            action: primaryAction ? primaryAction : null
            visible: primaryAction ? true : false
            display: IconLabel.IconOnly
            Layout.leftMargin: primaryAction ? 8 : 0
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
                Layout.minimumWidth: contentWidth + leftPadding + rightPadding
                leftPadding: 15
                rightPadding: 10
                visible: text.length > 0
            }

            XCaptionLabel {
                id: subtitleLabelCtrl
                Layout.minimumWidth: contentWidth + leftPadding + rightPadding
                leftPadding: 15
                rightPadding: 10
                visible: text.length > 0
            }
        }
    }

    RowLayout {
        id: menuActionsLayoutCtrl
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: menuActions && menuActions.length > 0 ? true : false
        spacing: 0

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
            icon.source: "qrc:/img/default-dots-vertical.svg"
            onClicked: overflowMenuCtrl.open()
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
                                ? menuActions[index + maxVisibleMenuActions - 1]
                                : null
                    }
                    onObjectAdded: overflowMenuCtrl.addItem(object)
                    onObjectRemoved: overflowMenuCtrl.removeItem(index)
                }
            }
        }
    }

    TabBar {
        id: tabbarCtrl
        padding: 0

        anchors.left: parent.left
        anchors.leftMargin: primaryAction ? primaryActionLayoutCtrl.width + buttonsLeftMargin : 0
        anchors.right: parent.right
        anchors.rightMargin: menuActions && menuActions.length > 0 ? menuActionsLayoutCtrl.width + buttonsRightMargin : 0
        anchors.verticalCenter: parent.verticalCenter

        background: null

        Instantiator {
            model: buttonActions ? buttonActions.length : 0
            delegate: XButtonNav {
                id: tabBtnCtrl
                checkable: true
                action: buttonActions[index]
                autoExclusive: true
                onClicked: {
                    buttonActions[index].checked = true
                }
            }
            onObjectAdded: {
                tabbarCtrl.addItem(object)
                if(buttonActions[index].checked)
                    tabbarCtrl.setCurrentIndex(index)
            }
            onObjectRemoved: tabbarCtrl.removeItem(index)
        }

        contentItem: ListView {
            model: tabbarCtrl.contentModel
            currentIndex: tabbarCtrl.currentIndex
            clip: true

            spacing: tabbarCtrl.spacing
            orientation: ListView.Horizontal
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.AutoFlickIfNeeded
            snapMode: ListView.SnapToItem
        }
    }

    background: Rectangle {
        id: bgItemCtrl
        color: paneCtrl.Material.backgroundColor
        implicitHeight: 50

        layer.enabled: paneCtrl.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: paneCtrl.Material.elevation
            fullWidth: true
        }
    }
}
