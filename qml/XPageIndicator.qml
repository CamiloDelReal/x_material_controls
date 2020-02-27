import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

PageIndicator {
    id: indicatorCtrl

    property bool highlighted: false
    property color highlightColor: indicatorCtrl.Material.primary

    property int delegateHeight: 8
    property int delegateWidth: 8

    delegate: Rectangle {
        id: delegateCtrl
        implicitWidth: indicatorCtrl.delegateWidth
        implicitHeight: indicatorCtrl.delegateHeight

        radius: width / 2
        color: !indicatorCtrl.enabled
               ? indicatorCtrl.Material.hintTextColor
               : (indicatorCtrl.highlighted
                  ? highlightColor
                  : indicatorCtrl.Material.foreground)

        opacity: index === currentIndex ? 0.95 : pressed ? 0.7 : 0.45
        Behavior on opacity { OpacityAnimator { duration: 200 } }
    }
}
