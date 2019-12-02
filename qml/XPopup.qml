import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.12

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
