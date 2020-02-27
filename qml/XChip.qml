import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Material.impl 2.14
import QtQuick.Layouts 1.14

Button {
    id: chip

    padding: 2
    topPadding: 2
    bottomPadding: 2
    leftPadding: (checkable && checked
                  ? 2
                  : imgIcon.status == Image.Null
                    ? 10
                    : 2)
    rightPadding: 10
    spacing: 6

    Material.elevation: chip.pressed ? 4 : 0

    font.pixelSize: 14
    font.capitalization: Font.MixedCase

    property bool deletable: false
    signal deleted()

    property alias image: imgIcon.source
    property alias checkIcon: imgCheck.icon.source

    contentItem: RowLayout {
        spacing: chip.spacing

        Item {
            Layout.alignment: Qt.AlignVCenter
            width: 28
            height: 28
            visible: ((imgIcon.status != Image.Null) || (chip.checkable && chip.checked))

            XRoundedImage {
                id: imgIcon
                anchors.centerIn: parent
                sourceSize.width: 28
                sourceSize.height: 28
                topLeftRadius: 14
                topRightRadius: 14
                bottomRightRadius: 14
                bottomLeftRadius: 14
                visible: status != Image.Null && !(chip.checkable && chip.checked)
            }

            IconLabel {
                id: imgCheck
                anchors.centerIn: parent
                icon.source: "qrc:/img/default-check.svg"
                icon.width: 24
                icon.height: 24
                icon.color: chip.Material.primaryTextColor
                visible: chip.checkable && chip.checked
            }
        }

        Label {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignLeft
            rightPadding: chip.deletable ? 8 : 0
            font: chip.font
            text: chip.text
            color: !chip.enabled
                   ? chip.Material.hintTextColor
                   : chip.highlighted
                     ? chip.Material.primaryHighlightedTextColor
                     : chip.Material.foreground
        }

        ToolButton {
            id: btnDelete
            Layout.alignment: Qt.AlignVCenter
            implicitHeight: 16
            implicitWidth: 16
            padding: 0
            icon.source: "qrc:/img/default-close.svg"
            icon.width: 14
            icon.height: 14
            icon.color: chip.Material.backgroundColor
            visible: chip.deletable
            onClicked: deleted()
            background: Rectangle {
                radius: height / 2
                color: chip.Material.secondaryTextColor
            }
        }
    }

    background: Rectangle {
        implicitHeight: 32
        radius: 16
        color: chip.Material.background

        layer.enabled: chip.Material.elevation
        layer.effect: ElevationEffect {
            elevation: chip.Material.elevation
        }

        Rectangle {
            anchors.fill: parent
            radius: 16
            color: !chip.enabled
                   ? chip.Material.buttonDisabledColor
                   : chip.highlighted
                     ? chip.Material.highlightedButtonColor
                     : chip.Material.rippleColor
        }

        Ripple {
            clipRadius: 16
            clip: true
            width: parent.width
            height: parent.height
            pressed: chip.pressed
            anchor: chip
            active: chip.down || chip.visualFocus || chip.hovered
            color: chip.Material.rippleColor
        }
    }
}
