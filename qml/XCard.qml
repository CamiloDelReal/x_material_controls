import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.12

ItemDelegate {
    id: cardCtrl
    padding: 10
    verticalPadding: 0
    horizontalPadding: 0

    Material.elevation: 4
    property int radius: 2
    property alias image: imageCtrl

    property alias header: headerContainer.children
    property alias footer: footerContainer.children

    contentItem: null


    XRoundedImage {
        id: imageCtrl
        anchors.fill: parent
        topLeftRadius: cardCtrl.radius
        topRightRadius: cardCtrl.radius
        bottomRightRadius: cardCtrl.radius
        bottomLeftRadius: cardCtrl.radius


        ColumnLayout {
            anchors.fill: parent
            clip: true

            Item {
                id: headerContainer
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                Layout.preferredHeight: children[0] ? children[0].height : 0
                visible: children.length > 0
            }

            Item {
                id: footerContainer
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignBottom
                Layout.preferredHeight: children[0] ? children[0].height : 0
                visible: children.length > 0
            }
        }
    }

    background: Rectangle {
        color: cardCtrl.Material.background
        radius: cardCtrl.radius

        layer.enabled: true
        layer.effect: ElevationEffect {
            elevation: cardCtrl.Material.elevation
        }

        Ripple {
            anchors.fill: parent
            clipRadius: cardCtrl.radius
            clip: true
            pressed: cardCtrl.pressed
            anchor: cardCtrl
            active: cardCtrl.down || cardCtrl.visualFocus || cardCtrl.hovered
            color: cardCtrl.Material.rippleColor
            parent: cardCtrl
        }
    }
}
