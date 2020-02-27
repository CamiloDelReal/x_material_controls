import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

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
