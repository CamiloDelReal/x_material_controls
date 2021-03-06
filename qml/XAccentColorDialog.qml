import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

XDialog {
    id: dialogCtrl
    parent: Overlay.overlay

    property string name: "AccentColorDialog"
    property var selectedColor

    title: qsTr("Select accent color")
    contentWidth: colorGridCtrl.implicitWidth
    contentHeight: colorGridCtrl.implicitHeight
    bottomPadding: 10

    property string checkIcon

    Component.onCompleted: {
        for(var i = 0; i < colorModelCtrl.count; i++) {
            if((dialogCtrl.Material.theme === Material.Light
                && dialogCtrl.Material.accent === Material.color(colorModelCtrl.get(i).colorCode))
                    || (dialogCtrl.Material.theme === Material.Dark
                        && dialogCtrl.Material.accent === Material.color(colorModelCtrl.get(i).colorCode, Material.Shade200))) {
                colorGridCtrl.children[i].checked = true
                break
            }
        }
    }

    ButtonGroup {
        id: checkButtonGroupCtrl
    }

    ListModel {
        id: colorModelCtrl
        ListElement { title: qsTr("Material Red"); colorCode: Material.Red }
        ListElement { title: qsTr("Material Pink"); colorCode: Material.Pink }
        ListElement { title: qsTr("Material Purple"); colorCode: Material.Purple }
        ListElement { title: qsTr("Material DeepPurple"); colorCode: Material.DeepPurple }
        ListElement { title: qsTr("Material Indigo"); colorCode: Material.Indigo }
        ListElement { title: qsTr("Material Blue"); colorCode: Material.Blue }
        ListElement { title: qsTr("Material LightBlue"); colorCode: Material.LightBlue }
        ListElement { title: qsTr("Material Cyan"); colorCode: Material.Cyan }
        ListElement { title: qsTr("Material Teal"); colorCode: Material.Teal }
        ListElement { title: qsTr("Material Green"); colorCode: Material.Green }
        ListElement { title: qsTr("Material LightGreen"); colorCode: Material.LightGreen }
        ListElement { title: qsTr("Material Lime"); colorCode: Material.Lime }
        ListElement { title: qsTr("Material Yellow"); colorCode: Material.Yellow }
        ListElement { title: qsTr("Material Amber"); colorCode: Material.Amber }
        ListElement { title: qsTr("Material Orange"); colorCode: Material.Orange }
        ListElement { title: qsTr("Material DeepOrange"); colorCode: Material.DeepOrange }
        ListElement { title: qsTr("Material Brown"); colorCode: Material.Brown }
        ListElement { title: qsTr("Material Grey"); colorCode: Material.Grey }
        ListElement { title: qsTr("Material BlueGrey"); colorCode: Material.BlueGrey }
    }

    Flickable {
        id: flickableCtrl
        anchors.fill: parent
        ScrollIndicator.vertical: ScrollIndicator {}
        ScrollIndicator.horizontal: ScrollIndicator {}
        contentHeight: colorGridCtrl.implicitHeight
        contentWidth: colorGridCtrl.implicitWidth
        clip: true

        Grid {
            id: colorGridCtrl
            columns: 4
            columnSpacing: 10
            rowSpacing: 10

            Repeater {
                model: colorModelCtrl

                RoundButton {
                    id: colorButtonCtrl
                    implicitWidth: 50
                    implicitHeight: 50
                    flat: true
                    padding: 0
                    checkable: true
                    ButtonGroup.group: checkButtonGroupCtrl

                    contentItem: Rectangle {
                        anchors.centerIn: parent
                        color: dialogCtrl.Material.theme === Material.Light
                               ? Material.color(colorCode)
                               : Material.color(colorCode, Material.Shade200)
                        radius: 25

                        Rectangle {
                            anchors.centerIn: parent
                            color: dialogCtrl.Material.theme === Material.Light
                                   ? Material.color(colorCode, Material.Shade700)
                                   : Material.color(colorCode, Material.Shade400)
                            width: 34
                            height: 34
                            radius: 17
                            scale: colorButtonCtrl.checked ? 1 : 0
                            visible: scale > 0
                            Behavior on scale { NumberAnimation { duration: 80 } }

                            IconLabel {
                                id: selectedMarkCtrl
                                anchors.centerIn: parent
                                display: IconLabel.IconOnly
                                icon.width: 28
                                icon.height: 28
                                icon.source: dialogCtrl.checkIcon
                                icon.color: "#FFFFFF"
                            }
                        }
                    }

                    onClicked: {
                        dialogCtrl.selectedColor = colorCode
                    }
                }
            }
        }
    }

    footer: DialogButtonBox {
        Button {
            text: qsTr("Close")
            flat: true
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }
    }
}
