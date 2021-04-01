import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

XPopup {
    id: dialogCtrl
    closePolicy: Popup.NoAutoClose
    topPadding: 10
    bottomPadding: 10
    leftPadding: 14
    rightPadding: 20

    property string name: "BusyDialog"

    contentWidth: contentLayout.implicitWidth
    contentHeight: contentLayout.implicitHeight

    function show(message) {
        labelCtrl.text = message ? message : qsTr("Please wait ...")
        open()
    }

    RowLayout {
        id: contentLayout
        spacing: 15

        BusyIndicator {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            implicitHeight: 50
            implicitWidth: 50
            running: dialogCtrl.opened
        }

        XBodyLabel1 {
            id: labelCtrl
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
        }
    }
}
