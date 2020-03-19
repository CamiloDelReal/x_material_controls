import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Material.impl 2.14
import QtQuick.Layouts 1.14

XScrollView {
    id: settingsCtrl

    property string title

    property list<XListSection> sections
    property bool useCheckableSwitch: true

    property int sectionLeftPadding: 12
    property int sectionTopPadding: 12
    property int sectionRightPadding: 12
    property int sectionBottomPadding: 12
    property color sectionBackgroundColor: settingsCtrl.Material.backgroundColor
    property int sectionElevation: 2
    property int sectionBorderRadius: 2
    property Component sectionBackground: Rectangle {
        color: sectionBackgroundColor
        radius: sectionBorderRadius

        layer.enabled: sectionElevation > 0
        layer.effect: ElevationEffect {
            elevation: sectionElevation
        }
    }

    Component {
        id: sectionDelegateCtrl

        Pane {
            id: sectionCtrl
            Layout.fillWidth: true
            leftPadding: sectionLeftPadding
            topPadding: sectionTopPadding
            rightPadding: sectionRightPadding
            bottomPadding: sectionBottomPadding

            background: Loader {
                sourceComponent: sectionBackground
            }

            ColumnLayout {
                id: sectionLayoutCtrl
                anchors.fill: parent
                spacing: 0

                XListGroupHeader {
                    Layout.fillWidth: true
                    text: title
                    topPadding: 2
                    bottomPadding: 8
                }

                Repeater {
                    model: !actions
                           ? 0
                           : actions

                    delegate: Loader {
                        Layout.fillWidth: true
                        property var itemAction: actions[index]
                        sourceComponent: (actions[index].checkable
                                          ? (settingsCtrl.useCheckableSwitch
                                             ? switchDelegateCtrl
                                             : checkDelegateCtrl)
                                          : itemDelegateCtrl)
                    }
                }
            }
        }
    }

    Component {
        id: itemDelegateCtrl

        XItemDelegate {
            Layout.fillWidth: true
            action: itemAction
            secondaryText: itemAction.tooltip
            secondaryItem: itemAction.secondaryItem
        }
    }

    Component {
        id: checkDelegateCtrl

        XCheckDelegate {
            Layout.fillWidth: true
            action: itemAction
            secondaryText: itemAction.tooltip
        }
    }

    Component {
        id: switchDelegateCtrl

        XSwitchDelegate {
            Layout.fillWidth: true
            action: itemAction
            secondaryText: itemAction.tooltip
        }
    }

    ColumnLayout {
        id: optionsLayout
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        spacing: 12

        Repeater {
            model: settingsCtrl.sections
                   ? settingsCtrl.sections
                   : 0
            delegate: sectionDelegateCtrl
        }
    }
}
