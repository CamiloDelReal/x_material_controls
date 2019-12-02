pragma Singleton

import QtQuick 2.12

Item {
    id: utilsCtrl

    function isDarkColor(color) {
        var temp = Qt.darker(color, 1)

        var a = 1 - ( 0.299 * temp.r + 0.587 * temp.g + 0.114 * temp.b);

        return temp.a > 0 && a >= 0.3
    }

    function isMobile() {
        return (Qt.platform.os == "android" || Qt.platform.os == "ios" || Qt.platform.os == "winrt")
    }
}
