import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Layouts

MenuItem {
    id: menuitemCtrl

    icon.width: 24
    icon.height: 24
    icon.color: !menuitemCtrl.enabled
           ? menuitemCtrl.Material.hintTextColor
           : menuitemCtrl.Material.secondaryTextColor

    property bool alignWithoutIcon: false
    leftPadding: 14 + (alignWithoutIcon ? (menuitemCtrl.icon.width + menuitemCtrl.spacing) : 0)
    rightPadding: 20
    topPadding: 0
    bottomPadding: 0
    spacing: 25
}
