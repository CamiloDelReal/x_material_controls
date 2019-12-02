import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

import XApps.XMaterialControls 1.0

RoundButton {
    id: roundBtnCtrl
    highlighted: true

    property bool tiny: false
    implicitHeight: tiny ? 48 : 64
    implicitWidth: tiny ? 48 : 64

    icon.color: XMaterialControls.isDarkColor(roundBtnCtrl.Material.accent) ? "#FFFFFFFF" : "#DD000000"
    icon.width: tiny ? 18 : 24
    icon.height: tiny ? 18 : 24
}
