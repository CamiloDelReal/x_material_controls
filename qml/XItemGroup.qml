import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

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

    property string expandedIcon: "qrc:/img/default-minus.svg"
    property string collapsedIcon: "qrc:/img/default-plus.svg"
    property int expandedIconSize: 16

    states: [
        State {
            name: "itemExpanded"
            when: !groupCtrl.isExpanded
            PropertyChanges { target: groupCtrl; height: headerCtrl.height }
            PropertyChanges { target: contentCtrl; height: 0 }
            PropertyChanges { target: expandedIconCtrl; icon.source: collapsedIcon }
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
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                color: headerCtrl.Material.secondaryTextColor
            }

            IconLabel {
                id: expandedIconCtrl
                Layout.alignment: Qt.AlignVCenter
                icon.source: expandedIcon
                icon.width: expandedIconSize
                display: IconLabel.IconOnly
                icon.color: headerCtrl.Material.secondaryTextColor
            }
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
