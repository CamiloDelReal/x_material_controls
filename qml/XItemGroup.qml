import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Material.impl 2.14
import QtQuick.Layouts 1.14

Pane {
    id: groupCtrl
    height: headerCtrl.height + (groupCtrl.isExpanded ? layoutCtrl.implicitHeight : 0)
    clip: true
    padding: 0
    Behavior on height{ NumberAnimation { duration: 150 } }
    Material.background: "transparent"

    default property alias groupContent: layoutCtrl.data
    property alias title: headerCtrl.text
    property bool isExpanded: true

    states: [
        State {
            name: "itemExpanded"
            when: !groupCtrl.isExpanded
            //PropertyChanges { target: plusMinusIcon; iconName: "expand_more" }
            PropertyChanges { target: groupCtrl; height: header.height }
            PropertyChanges { target: contentCtrl; height: 0 }
        }
    ]

    transitions: [
        Transition {
            to: "itemExpanded"
            PropertyAnimation { target: groupCtrl; properties: "height"; duration: 150; easing.type: Easing.InOutQuad }
            PropertyAnimation { target: contentCtrl; properties: "height"; duration: 150; easing.type: Easing.InOutQuad }
        },
        Transition {
            from: "itemExpanded"
            PropertyAnimation { target: groupCtrl; properties: "height"; duration: 150; easing.type: Easing.InOutQuad }
            PropertyAnimation { target: contentCtrl; properties: "height"; duration: 150; easing.type: Easing.InOutQuad }
        }
    ]

    ItemDelegate {
        id: headerCtrl
        leftPadding: 2
        rightPadding: 2
        topPadding: 5
        bottomPadding: 4
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        implicitHeight: 35

        onClicked: {
            if(groupCtrl.isExpanded)
                groupCtrl.isExpanded = false
            else
                groupCtrl.isExpanded = true
        }

        contentItem: RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 13
            anchors.rightMargin: 13

            XCaptionLabel {
                text: headerCtrl.text
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                Layout.fillWidth: true
                color: headerCtrl.Material.secondaryTextColor
            }

//            XMaterialIcon {
//                id: plusMinusIcon
//                iconSize: 20
//                iconColor: header.Material.secondaryTextColor
//                iconName: "expand_less"
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.right: parent.right
//                anchors.rightMargin: 3
//            }
        }

        XListSeparator { childMode: true }
    }

    Pane {
        id: contentCtrl
        padding: 0
        anchors.top: headerCtrl.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: layoutCtrl.implicitHeight
        Behavior on height{ NumberAnimation { duration: 150 } }

        background: Rectangle {
            color: "transparent"
        }

        ColumnLayout {
            id: layoutCtrl
            anchors.fill: parent
            spacing: 0
        }
    }
}
