import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material

TabButton {
    id: tabBtnCtrl

    property alias textColor: lblIconText.color

    icon.color: !tabBtnCtrl.enabled
                ? tabBtnCtrl.Material.hintTextColor
                : tabBtnCtrl.checked
                  ? tabBtnCtrl.Material.foreground
                  : tabBtnCtrl.Material.secondaryTextColor

    contentItem: IconLabel {
        id: lblIconText
        spacing: tabBtnCtrl.spacing
        mirrored: tabBtnCtrl.mirrored
        display: tabBtnCtrl.display

        icon: tabBtnCtrl.icon
        text: tabBtnCtrl.text
        font: tabBtnCtrl.font
        color: !tabBtnCtrl.enabled
               ? tabBtnCtrl.Material.hintTextColor
               : tabBtnCtrl.checked
                 ? tabBtnCtrl.Material.foreground
                 : tabBtnCtrl.Material.secondaryTextColor
    }
}
