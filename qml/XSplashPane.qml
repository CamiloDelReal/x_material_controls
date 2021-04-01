import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Layouts

import XApps.XMaterialControls

Pane {
    id: splashPaneCtrl

    property int modelIndex: -1

    property alias logo: logo

    property alias contentLayout: contentLayoutCtrl
    default property alias items: contentLayoutCtrl.children

    Material.theme: XMaterialControls.isDarkColor(bgItemCtrl
                                                  ? bgItemCtrl.color
                                                  : toolbarCtrl.Material.primary)
                    ? Material.Dark : Material.Light

    ColumnLayout {
        id: contentLayoutCtrl
        anchors.centerIn: parent

        IconImage {
            id: logo
            Layout.alignment: Qt.AlignHCenter
            sourceSize: Qt.size(92, 92)
            source: splashPaneCtrl.Material.theme === Material.Dark
                    ? "qrc:/img/unknow-picture-dark.svg"
                    : "qrc:/img/unknow-picture-light.svg"
        }

    }

    background: Rectangle {
        id: bgItemCtrl
        color: splashPaneCtrl.Material.backgroundColor
    }

}
