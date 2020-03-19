import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Material.impl 2.14

import XApps.XMaterialControls 1.0

ToolBar {
    id: toolbarCtrl

    // To fix Qt bug
    Material.theme: XMaterialControls.isDarkColor(bgItemCtrl
                                                  ? bgItemCtrl.color
                                                  : toolbarCtrl.Material.primary)
                    ? Material.Dark : Material.Light

    property alias backgroundCtrl: bgItemCtrl
    property alias backgroundRadius: bgItemCtrl.radius
    property alias backgroundColor: bgItemCtrl.color

    property int topMargin: 0
    property int rightMargin: 0
    property int bottomMargin: 0
    property int leftMargin: 0
//    bottomInset: 10

    background: Rectangle {
        id: bgItemCtrl
        implicitHeight: 48
        color: toolbarCtrl.Material.primary

        layer.enabled: toolbarCtrl.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: toolbarCtrl.Material.elevation
            fullWidth: true
        }
    }
}
