import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12

TabButton {
    id: tabBtnCtrl
    padding: 6
    spacing: 2

    property alias textColor: lblIconCtrl.color

    icon.width: 23
    icon.height: 23
    icon.color: !tabBtnCtrl.enabled
                ? tabBtnCtrl.Material.hintTextColor
                : tabBtnCtrl.checked
                  ? tabBtnCtrl.Material.accent
                  : tabBtnCtrl.Material.foreground

    contentItem: IconLabel {
        id: lblIconCtrl
        spacing: tabBtnCtrl.spacing
        mirrored: tabBtnCtrl.mirrored
        display: IconLabel.TextUnderIcon

        icon: tabBtnCtrl.icon
        text: tabBtnCtrl.text
        font.family: tabBtnCtrl.font.family
        font.pixelSize: 11
        color: !tabBtnCtrl.enabled
               ? tabBtnCtrl.Material.hintTextColor
               : tabBtnCtrl.checked
                 ? tabBtnCtrl.Material.accent
                 : tabBtnCtrl.Material.foreground
    }
}
