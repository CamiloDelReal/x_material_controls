import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Pane {
    id: headerCtrl
    implicitHeight: sectionCtrl.height + topPadding + bottomPadding

    topPadding: 4
    bottomPadding: 4
    leftPadding: 0
    rightPadding: 0

    property alias textPadding: sectionCtrl.padding
    property alias textLeftPadding: sectionCtrl.leftPadding
    property alias textTopPadding: sectionCtrl.topPadding
    property alias textRightPadding: sectionCtrl.rightPadding
    property alias textBottomPadding: sectionCtrl.bottomPadding

    property alias label: sectionCtrl
    property alias text: sectionCtrl.text
    property alias textColor: sectionCtrl.color
    property alias horizontalAligment: sectionCtrl.horizontalAlignment

    property bool dividerOnTop: true
    property alias dividerVisible: dividerCtrl.visible

    Label {
        id: sectionCtrl
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        topPadding: 8
        bottomPadding: 0
        leftPadding: horizontalAligment === Label.AlignHCenter ? 2 : 12
        rightPadding: horizontalAligment === Label.AlignHCenter ? 2 : 12
        font.pixelSize: 14
        font.bold: false
        font.weight: Font.Normal
        color: headerCtrl.Material.accent
        visible: true
    }

    Rectangle {
        id: dividerCtrl
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: headerCtrl.dividerOnTop ? undefined : parent.bottom
        anchors.top: headerCtrl.dividerOnTop ? parent.top : undefined
        height: 1
        visible: false
        color: headerCtrl.Material.dividerColor
    }

    background: Item {}
}
