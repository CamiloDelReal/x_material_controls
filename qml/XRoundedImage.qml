import QtQuick 2.14
import QtGraphicalEffects 1.14

Image {
    id: imageCtrl
    fillMode: Image.PreserveAspectCrop
    asynchronous: true

    visible: status == Image.Ready && maskCompleted == true
    opacity: visible ? 1 : 0
    Behavior on opacity { NumberAnimation {} }

    property bool maskCompleted: false

    property int topLeftRadius: 10
    property int topRightRadius: 10
    property int bottomRightRadius: 10
    property int bottomLeftRadius: 10

    layer.enabled: true
    layer.effect: XRoundedMask {
        id: roundedMask

        // I can't use alias in root control
        topLeftRadius: imageCtrl.topLeftRadius
        topRightRadius: imageCtrl.topRightRadius
        bottomRightRadius: imageCtrl.bottomRightRadius
        bottomLeftRadius: imageCtrl.bottomLeftRadius

        onPaintStarted: imageCtrl.maskCompleted = false
        onPaintCompleted: imageCtrl.maskCompleted = true
    }
}
