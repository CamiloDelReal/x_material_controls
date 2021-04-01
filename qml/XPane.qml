import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

Pane {
    id: paneCtrl
    padding: 12

    property string title: ""
    property int modelIndex: -1

    property int radius: 2

    function back() {
        return false
    }

    background: Rectangle {
        color: paneCtrl.Material.backgroundColor
        radius: paneCtrl.Material.elevation > 0 ? paneCtrl.radius : 0

        layer.enabled: paneCtrl.enabled && paneCtrl.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: paneCtrl.Material.elevation
        }
    }
}
