import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material

import XApps.XMaterialControls

Rectangle {
    id: badgeCtrl
    color: badgeCtrl.Material.accent
    radius: rounded ? (height * 0.48) : 0
    height: iconLabelCtrl.implicitHeight + 2
    width: iconLabelCtrl.implicitWidth + 12

    property alias text: iconLabelCtrl.text
    property alias icon: iconLabelCtrl.icon
    property bool rounded: true
    property alias topPadding: iconLabelCtrl.leftPadding
    property alias rightPadding: iconLabelCtrl.rightPadding
    property alias bottomPadding: iconLabelCtrl.bottomPadding
    property alias leftPadding: iconLabelCtrl.leftPadding

    IconLabel {
        id: iconLabelCtrl
        anchors.fill: parent
        font.pixelSize: 12
        font.bold: false
        font.weight: Font.Normal
        leftPadding: 2
        topPadding: 2
        rightPadding: 2
        bottomPadding: 2
        Material.theme: XMaterialControls.isDarkColor(badgeCtrl.Material.accent)
                        ? Material.Dark
                        : Material.Light
        color: Material.foreground
    }
}
