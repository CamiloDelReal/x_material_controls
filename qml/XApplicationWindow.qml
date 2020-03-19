import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Material.impl 2.14

ApplicationWindow {
    id: windowCtrl

    color: Material.backgroundColor

    Overlay.modal: Rectangle {
        color: "#99303030"
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    Overlay.modeless: Rectangle {
        color: "#99303030"
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }
}
