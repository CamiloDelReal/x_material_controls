import QtQuick
import QtQuick.Controls

Menu {
    id: menuCtrl

    property bool fixedWidth: true

    width: {
        var result = implicitWidth;
        if(!fixedWidth) {
            for (var i = 0; i < count; i++) {
                var item = itemAt(i)
                result = Math.max(item.implicitWidth, result)
            }
        }

        return result
    }
}
