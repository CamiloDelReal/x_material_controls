import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

SwitchDelegate {
    id: delegateCtrl
    leftPadding: 12
    rightPadding: 12
    topPadding: 13
    bottomPadding: 13
    spacing: 16

    property alias textMaxLineCount: primaryLabelCtrl.maximumLineCount
    property alias secondaryText: secondaryLabelCtrl.text
    property alias secondaryTextMaxLineCount: secondaryLabelCtrl.maximumLineCount
    property color highlightedColor: delegateCtrl.Material.accent
    property bool iconCentered: true

    icon.width: 24
    icon.height: 24
    icon.color: !delegateCtrl.enabled
                ? delegateCtrl.Material.hintTextColor
                : (highlighted
                   ? highlightedColor
                   : delegateCtrl.Material.secondaryTextColor)

    contentItem: RowLayout {
        spacing: delegateCtrl.spacing

        IconLabel {
            id: itemIcon
            Layout.alignment: iconCentered ? Qt.AlignVCenter : Qt.AlignTop
            icon: delegateCtrl.icon
            display: IconLabel.IconOnly
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: delegateCtrl.spacing * 0.25

            XSubheadingLabel {
                id: primaryLabelCtrl
                text: delegateCtrl.text
                Layout.fillWidth: true
                wrapMode: Label.WrapAtWordBoundaryOrAnywhere
                maximumLineCount: 1
                elide: Label.ElideRight
                rightPadding: delegateCtrl.indicator.width
                              + delegateCtrl.rightPadding
                              + delegateCtrl.spacing
                color: !delegateCtrl.enabled
                       ? delegateCtrl.Material.hintTextColor
                       : (highlighted
                          ? highlightedColor
                          : delegateCtrl.Material.foreground)
            }

            XBodyLabel1 {
                id: secondaryLabelCtrl
                Layout.fillWidth: true
                wrapMode: Label.WrapAtWordBoundaryOrAnywhere
                maximumLineCount: 2
                elide: Label.ElideRight
                color: !delegateCtrl.enabled
                       ? delegateCtrl.Material.hintTextColor
                       : delegateCtrl.Material.secondaryTextColor
                visible: text.length > 0
                rightPadding: delegateCtrl.indicator.width
                              + delegateCtrl.rightPadding
                              + delegateCtrl.spacing
            }
        }
    }
}
