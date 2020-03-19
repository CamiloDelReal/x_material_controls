import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

Flickable {
    id: flickableCtrl
    contentHeight: contentViewCtrl.height + topPadding + bottomPadding

    property int modelIndex: -1

    property int leftPadding: 0
    property int topPadding: 0
    property int rightPadding: 0
    property int bottomPadding: 0

    property alias contentView: contentViewCtrl
    default property alias contentData: contentViewCtrl.contentData

    Pane {
        id: contentViewCtrl
        anchors.left: parent.left
        anchors.leftMargin: flickableCtrl.leftPadding
        anchors.top: parent.top
        anchors.topMargin: flickableCtrl.topPadding
        anchors.right: parent.right
        anchors.rightMargin: flickableCtrl.rightPadding
        padding: 12
        Material.elevation: flickableCtrl.Material.elevation
    }
}
