import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

ItemDelegate {
    id: itemCtrl
    padding: 10
    verticalPadding: 0
    horizontalPadding: 0

    Material.elevation: 0
    property int radius: 0

    contentItem: null

    background: Rectangle {
        color: itemCtrl.Material.background
        radius: itemCtrl.radius

        layer.enabled: true
        layer.effect: ElevationEffect {
            elevation: itemCtrl.Material.elevation
        }

        Ripple {
            anchors.fill: parent
            clipRadius: itemCtrl.radius
            clip: true
            width: parent.height / 2
            height: parent.height / 2
            pressed: itemCtrl.pressed
            anchor: itemCtrl
            active: itemCtrl.down || itemCtrl.visualFocus || itemCtrl.hovered
            color: itemCtrl.Material.rippleColor
            parent: itemCtrl
        }
    }
}
