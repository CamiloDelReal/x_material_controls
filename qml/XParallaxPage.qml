import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

XPage {
    id: page
    padding: 0

    property int statusBarHeight: 0

    property alias toolbar: toolbarCtrl

    property XAction primaryAction

    property alias floatingTitle: titleLabelCtrl.text
    property alias floatingSubtitle: subtitleLabelCtrl.text
    property alias parallaxItem: parallaxContainer.children
    onParallaxItemChanged: {
        if(parallaxItem.length > 0 && parallaxItem[0] !== undefined) {
            parallaxItem[0].anchors.centerIn = parallaxContainer
            parallaxContainer.widthChanged.connect(prepareParallaxItem)
            page.maximunHeightChanged.connect(prepareParallaxItem)
        } else {
            parallaxContainer.widthChanged.disconnect(prepareParallaxItem)
            page.maximunHeightChanged.disconnect(prepareParallaxItem)
        }
    }

    function prepareParallaxItem() {
        parallaxItem[0].width = parallaxContainer.width
        parallaxItem[0].height = maximunHeight
        parallaxItem[0].anchors.centerIn = parallaxContainer
    }

    property list<XAction> menuActions
    property int maxVisibleMenuActions: 2

    property alias overflowIcon: overflowBtnCtrl.icon.source
    property string overflowTooltip: qsTr("More actions")

    property int starterY: 0
    property int minimunHeight: 48
    property int maximunHeight: 220
    property int hiddenHeight: maximunHeight - minimunHeight - statusBarHeight

    property Flickable flickable: null
    onFlickableChanged: {
        if(flickable) {
            flickable.topMargin = maximunHeight + starterY
            if(flickable.hasOwnProperty("displayMarginBeginning")) {
                flickable.displayMarginBeginning = maximunHeight + starterY + 100
            }

            var initialY = maximunHeight
            if(flickable.hasOwnProperty("headerItem") && flickable.headerItem !== null) {
                initialY += (flickable.headerItem.height > 0
                             ? flickable.headerItem.height
                             : flickable.headerItem.implicitHeight)
            }
            flickable.contentY = -initialY
        }
    }

    property ScrollIndicator scrollIndicator: null
    onScrollIndicatorChanged: {
        if(scrollIndicator && scrollIndicator.hasOwnProperty("topPadding")) {
            scrollIndicator.topPadding = maximunHeight + toolbarCtrl.y
            toolbarCtrl.onYChanged.connect(updateScrollIndicatorProperties)
        }
    }
    function updateScrollIndicatorProperties() {
        scrollIndicator.topPadding = maximunHeight + toolbarCtrl.y
    }

    property alias contentView: contentViewCtrl
    default property alias contentViewData: contentViewCtrl.contentData


    AnimationController {
        progress: (1 - (flickable.contentItem.y -(maximunHeight - hiddenHeight + starterY)) / (hiddenHeight))
        animation: ParallelAnimation {
            NumberAnimation {
                target: toolbarCtrl
                property: "y"
                from: starterY
                to: -hiddenHeight
            }
            NumberAnimation {
                target: titleContainer
                property: "height"
                from: 80
                to: minimunHeight
            }
            NumberAnimation {
                target: titleContainer
                property: "anchors.leftMargin"
                from: 0
                to: primaryActionLayout.width
            }
            NumberAnimation {
                target: titleContainer
                property: "anchors.rightMargin"
                from: 0
                to: menuActionsLayout.width
            }
            NumberAnimation {
                target: titleLabelCtrl
                property: "font.pixelSize"
                from: 32
                to: 20
            }
            NumberAnimation {
                target: parallaxContainer
                property: "height"
                from: maximunHeight
                to: minimunHeight + statusBarHeight
            }
            NumberAnimation {
                target: parallaxContainer
                property: "opacity"
                from: 1
                to: 0
            }
        }
    }

    XToolBar {
        id: toolbarCtrl
        y: 0
        anchors.left: parent.left
        anchors.right: parent.right
        height: maximunHeight
        z: 100

        Item {
            id: parallaxContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: maximunHeight
            clip: true
        }

        RowLayout {
            id: primaryActionLayout
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: hiddenHeight + toolbarCtrl.y
            height: minimunHeight
            spacing: 0

            ToolButton {
                id: btnPrimaryAction
                Layout.alignment: Qt.AlignVCenter
                visible: primaryAction
                action: primaryAction ? primaryAction : null
                icon.color: primaryAction && primaryAction.customIconColor
                            ? primaryAction.icon.color
                            : toolbarCtrl.Material.foreground
                icon.width: primaryAction ? primaryAction.icon.width : 0
                icon.height: primaryAction ? primaryAction.icon.height : 0
                display: IconLabel.IconOnly
                ToolTip.text: btnPrimaryAction.text
                ToolTip.visible: ToolTip.text != "" && down
                ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
            }
        }

        RowLayout {
            id: menuActionsLayout
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: hiddenHeight + toolbarCtrl.y
            height: minimunHeight
            spacing: 0

            Repeater {
                model: (!menuActions
                        ? 0
                        : (menuActions.length > Math.max(maxVisibleMenuActions, 1)
                           ? (maxVisibleMenuActions - 1)
                           : menuActions.length))

                delegate: ToolButton {
                    id: actionBtnCtrl
                    Layout.alignment: Qt.AlignVCenter
                    action: menuActions[index]
                    icon.color: menuActions[index].customIconColor
                                ? menuActions[index].icon.color
                                : toolbarCtrl.Material.foreground
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

        Item {
            id: titleContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 80

            ColumnLayout {
                id: titleLayout
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: 0

                XTitleLabel {
                    id: titleLabelCtrl
                    Layout.fillWidth: true
                    elide: Label.ElideRight
                    leftPadding: 15
                    rightPadding: 10
                }

                XCaptionLabel {
                    id: subtitleLabelCtrl
                    Layout.fillWidth: true
                    elide: Label.ElideRight
                    leftPadding: 15
                    rightPadding: 10
                    visible: text.length > 0
                }
            }
        }
    }

    XPane {
        id: contentViewCtrl
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: flickable
                           ? 0
                           : toolbarCtrl.height
        padding: 0
    }
}
