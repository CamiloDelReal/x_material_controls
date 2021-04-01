import QtQuick 2.14
import Qt5Compat.GraphicalEffects

OpacityMask {
    id: effect

    signal paintStarted
    signal paintCompleted

    property int topLeftRadius: 10
    property int topRightRadius: 10
    property int bottomRightRadius: 10
    property int bottomLeftRadius: 10

    maskSource: Canvas {
        id: canvas
        anchors.centerIn: parent
        width: effect.width
        height: effect.height
        antialiasing: true
        visible: false
        renderStrategy: Canvas.Threaded

        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()

        onPaint: {
            effect.paintStarted()
            var ctx = getContext("2d")
            ctx.save()
            ctx.clearRect(0,0,canvas.width, canvas.height)
            ctx.strokeStyle = "#ffffff"
            ctx.lineWidth = 1
            ctx.fillStyle = "#00ffff"
            ctx.globalAlpha = 1.0
            ctx.beginPath()
            ctx.moveTo(effect.topLeftRadius, 0)
            ctx.lineTo(width - effect.topRightRadius, 0)
            // draw top right corner
            ctx.arcTo(width, 0, width, effect.topRightRadius, effect.topRightRadius)
            ctx.lineTo(width, height - effect.bottomRightRadius)
            // draw bottom right corner
            ctx.arcTo(width, height, width - effect.bottomRightRadius, height, effect.bottomRightRadius)
            ctx.lineTo(effect.bottomLeftRadius, height)
            // draw bottom left corner
            ctx.arcTo(0, height, 0, height - effect.bottomLeftRadius, effect.bottomLeftRadius)
            ctx.lineTo(0, height - effect.topLeftRadius)
            ctx.arcTo(0, 0, effect.topLeftRadius, 0, effect.topLeftRadius)
            ctx.closePath()

            ctx.fill()
            ctx.restore()
            effect.paintCompleted()
        }
    }
}
