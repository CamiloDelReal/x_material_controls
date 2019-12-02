import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.12

Popup {
    id: messageCtrl
    closePolicy: Popup.CloseOnPressOutside
    bottomMargin: 24
    parent: ApplicationWindow.overlay
    x: (parent.width - width) / 2
    y: parent.height - height
    padding: 4
    leftPadding: 16
    rightPadding: 16
    dim: false
    modal: false
    Material.theme: Material.Dark
//    Material.theme: parent.Material.theme === Material.Light ? Material.Dark : Material.Light
    Material.elevation: 12

    property alias duration: messageTimerCtrl.interval

    signal requestReopened()

    background: Rectangle {
        implicitHeight: 48
        color: messageCtrl.Material.background
        radius: messageCtrl.Material.elevation > 0 ? 1 : 0

        layer.enabled: messageCtrl.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: messageCtrl.Material.elevation
        }
    }

    Timer {
        id: messageTimerCtrl
        interval: 2000
        repeat: false
        onTriggered: {
            messageCtrl.close()
        }
    }

    onAboutToShow: {
        messageTimerCtrl.start()
    }
    onClosed: {
        if(messageTimerCtrl.running)
            messageTimerCtrl.stop()
    }

    function show(action) {
        iconCtrl.icon.source = action.icon.source
        labelCtrl.text = action.tooltip
        btnAction.text = action.text
        btnAction.action = action
        if(!messageTimerCtrl.running) {
            open()
        }
        else {
            messageTimerCtrl.restart()
            requestReopened()
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 12

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
            color: messageCtrl.Material.primaryTextColor
            wrapMode: Label.WordWrap
            elide: Label.ElideRight
            maximumLineCount: 2
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
        }

        Button {
            id: btnAction
            highlighted: true
            flat: true
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 12
            display: IconLabel.TextOnly
            visible: text.length > 0
            onClicked: {
                messageCtrl.close()
            }
        }
    }
}
