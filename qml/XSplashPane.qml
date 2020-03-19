import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

import XApps.XMaterialControls 1.0

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
