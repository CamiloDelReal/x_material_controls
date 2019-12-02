import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Pane {
    id: splashPaneCtrl

    property int modelIndex: -1

    property alias logo: logo.source
    property alias logoWidth: logo.sourceSize.width
    property alias logoHeight: logo.sourceSize.height

    Image {
        id: logo
        anchors.centerIn: parent
        sourceSize.width: 192
        sourceSize.height: 192
        source: splashPaneCtrl.Material.theme === Material.Dark
                ? "qrc:/img/unknow_picture_dark.svg"
                : "qrc:/img/unknow_picture_light.svg"
    }
}