import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import XApps.XMaterialControls

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
