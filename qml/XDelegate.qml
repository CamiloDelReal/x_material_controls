import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Material.impl 2.14

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
            pressed: itemCtrl.pressed
            anchor: itemCtrl
            active: itemCtrl.down || itemCtrl.visualFocus || itemCtrl.hovered
            color: itemCtrl.Material.rippleColor
            parent: itemCtrl
        }
    }
}
