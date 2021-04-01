import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Item {
    id: separatorCtrl
    height: lineCtrl.height + topPadding + bottomPadding

    property int position: Qt.AlignBottom
    property bool childMode: false
    property int leftPadding: 0
    property int rightPadding: 0
    property int topPadding: childMode ? 0 : 4
    property int bottomPadding: childMode ? 0 : 4

    anchors.left: childMode ? parent.left : undefined
    anchors.right: childMode ? parent.right : undefined
    anchors.top: childMode
                 ? (position === Qt.AlignTop ? parent.top : undefined)
                 : undefined
    anchors.bottom: childMode
                    ? (position === Qt.AlignBottom ? parent.bottom : undefined)
                    : undefined

    Rectangle {
        id: lineCtrl
        height: 1
        color: separatorCtrl.Material.dividerColor

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: leftPadding
        anchors.right: parent.right
        anchors.rightMargin: rightPadding
    }
}
