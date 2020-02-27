import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14

Action {
    id: actionCtrl

    checkable: false
    checked: false

    property bool customIconColor: false

    icon.width: 24
    icon.height: 24

    property int spacing: 6
    property int display: IconLabel.TextBesideIcon

    property string tooltip
    property string category: " "

    property Item secondaryItem: null
}
