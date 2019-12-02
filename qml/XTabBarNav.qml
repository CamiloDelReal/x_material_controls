import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.12

Pane {
    id: paneCtrl
    padding: 0
    Material.foreground: Material.primaryTextColor
    z: 20

    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             tabbarCtrl.implicitHeight)

    property bool highlightVisible: true
    property alias backgroundColor: bgItemCtrl.color

    property XAction primaryAction

    property alias title: titleLabelCtrl.text
    property alias subtitle: subtitleLabelCtrl.text

    property list<XAction> tabActions
    property int tabsLeftMargin: 8
    property int tabsRightMargin: 8

    property alias currentIndex: tabbarCtrl.currentIndex

    property list<XAction> menuActions
    property int maxVisibleMenuActions: 2

    property url overflowIcon
    property string overflowTooltip: qsTr("More actions")

    RowLayout {
        id: primaryActionLayoutCtrl
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: primaryAction || title.length > 0 || subtitle.length > 0
                 ? true : false
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
            icon.source: overflowIcon
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
        Material.foreground: Material.toolTextColor
        padding: 0

        implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                listviewCtrl.width + leftPadding + rightPadding)
        anchors.left: parent.left
        anchors.leftMargin: primaryActionLayoutCtrl.visible
                            ? tabsLeftMargin + primaryActionLayoutCtrl.width
                            : 0
        anchors.right: parent.right
        anchors.rightMargin: menuActions && menuActions.length > 0 ? menuActionsLayoutCtrl.width + tabsRightMargin : 0
        anchors.bottom: parent.bottom

        background: null

        Instantiator {
            model: tabActions ? tabActions : 0
            delegate: XTabNav {
                id: btnTab
                checkable: true
                action: tabActions[index]
                display: tabActions[index].display
                spacing: tabActions[index].spacing
                autoExclusive: true
                width: Math.max(btnTab.implicitWidth,
                                (listviewCtrl.width
                                 - (tabbarCtrl.spacing * (tabActions.length - 1)))/ tabActions.length)
                onClicked: {
                    tabActions[index].checked = true
                }
            }
            onObjectAdded: {
                tabbarCtrl.addItem(object)
                if(tabActions[index].checked)
                    tabbarCtrl.setCurrentIndex(index)
            }
            onObjectRemoved: tabbarCtrl.removeItem(index)
        }

        contentItem: ListView {
            id: listviewCtrl
            clip: true
            model: tabbarCtrl.contentModel
            currentIndex: tabbarCtrl.currentIndex

            spacing: tabbarCtrl.spacing
            orientation: ListView.Horizontal
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.AutoFlickIfNeeded
            snapMode: ListView.SnapToItem

            highlightMoveDuration: 250
            highlightResizeDuration: 0
            highlightFollowsCurrentItem: true
            highlightRangeMode: ListView.NoHighlightRange

            highlight: Item {
                z: 2
                visible: paneCtrl.highlightVisible
                Rectangle {
                    height: 2
                    width: parent.width
                    Behavior on width { NumberAnimation { duration: 250 } }
                    y: parent.height - height
                    color: tabbarCtrl.Material.toolTextColor
                }
            }
        }
    }

    background: Rectangle {
        id: bgItemCtrl
        implicitHeight: 48
        color: paneCtrl.Material.toolBarColor
    }
}


