import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

Popup {
    id: popupCtrl
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    modal: true
    padding: 8
    parent: ApplicationWindow.overlay
    Material.primary: parent.Material.primary
    Material.accent: parent.Material.accent
    Material.theme: parent.Material.theme

    Overlay.modal: Rectangle {
        color: "#99303030"
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    Overlay.modeless: Rectangle {
        color: "#99303030"
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }
}
