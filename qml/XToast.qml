import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.12

Popup {
    id: popupCtrl
    closePolicy: Popup.CloseOnPressOutside
    bottomMargin: 24
    parent: ApplicationWindow.overlay
    x: (parent.width - width) / 2
    y: (parent.height - height)
    padding: 14
    leftPadding: 18
    rightPadding: 18
    dim: false
    modal: false
    Material.theme: Material.Dark
//    Material.theme: parent.Material.theme === Material.Light ? Material.Dark : Material.Light
    Material.elevation: 1

    property alias duration: popupTimer.interval

    signal requestReopened()

    background: Rectangle {
        radius: height / 2
        color: popupCtrl.Material.background

        layer.enabled: popupCtrl.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: popupCtrl.Material.elevation
        }
    }

    Timer {
        id: popupTimer
        interval: 2000
        repeat: false
        onTriggered: {
            popupCtrl.close()
        }
    }

    onAboutToShow: {
        popupTimer.start()
    }
    onClosed: {
        if(popupTimer.running)
            popupTimer.stop()
    }

    // If the icon is not required, pass null
    function showIconWithText(icon, text) {
        iconCtrl.icon.source = icon !== null ? icon : ""
        labelCtrl.text = text
        if(!popupTimer.running) {
            open()
        }
        else {
            popupTimer.restart()
            requestReopened()
        }
    }

    function showText(text) {
        showIconWithText(null, text)
    }

    RowLayout {
        spacing: 14

        IconLabel {
            id: iconCtrl
            icon.color: Material.foreground
            icon.width: 20
            icon.height: 20
            Layout.alignment: Qt.AlignVCenter
        }

        XBodyLabel1 {
            id: labelCtrl
            width: parent.width
            wrapMode: Label.WrapAtWordBoundaryOrAnywhere
            maximumLineCount: 2
            elide: Label.ElideRight
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
