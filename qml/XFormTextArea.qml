import QtQuick 2.14
import QtQuick.Templates 2.14 as T
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Material.impl 2.14

T.TextArea {
    id: textareaCtrl

    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            background ? background.implicitWidth : 0,
                            placeholderCtrl.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + 1 + topPadding + bottomPadding,
                             background ? background.implicitHeight : 0,
                             placeholderCtrl.implicitHeight + 1 + topPadding + bottomPadding)

    topPadding: 20
    bottomPadding: 10
    leftPadding: 1
    rightPadding: 1

    color: enabled ? Material.foreground : Material.hintTextColor
    selectionColor: Material.accentColor
    selectedTextColor: Material.primaryHighlightedTextColor
    wrapMode: TextArea.WordWrap
    property alias backgroundOpacity: bgItemCtrl.opacity

    cursorDelegate: CursorDelegate { }

    PlaceholderText {
        id: placeholderCtrl
        x: textareaCtrl.activeFocus || textareaCtrl.text.length ? 0 : textareaCtrl.leftPadding
        y: textareaCtrl.activeFocus || textareaCtrl.text.length ? ((textareaCtrl.topPadding - placeholderCtrl.height) / 2) : textareaCtrl.topPadding
        Behavior on x { NumberAnimation { duration: 100 } }
        Behavior on y { NumberAnimation { duration: 100 } }
        width: textareaCtrl.width - (textareaCtrl.leftPadding + textareaCtrl.rightPadding)
        text: textareaCtrl.placeholderText
        font.family: textareaCtrl.font.family
        font.pixelSize: textareaCtrl.activeFocus || textareaCtrl.text.length ? 12 : textareaCtrl.font.pixelSize
        Behavior on font.pixelSize { NumberAnimation { duration: 100 } }
        color: textareaCtrl.activeFocus ? textareaCtrl.Material.accent : textareaCtrl.Material.hintTextColor
        verticalAlignment: textareaCtrl.verticalAlignment
        elide: Text.ElideRight
        visible: textareaCtrl.placeholderText.length
    }

    background: Rectangle {
        id: bgItemCtrl
        y: textareaCtrl.height - height - (textareaCtrl.bottomPadding * 0.45)
        implicitWidth: 120
        height: textareaCtrl.activeFocus ? 2 : 1
        color: textareaCtrl.activeFocus ? textareaCtrl.Material.accentColor
                                   : (textareaCtrl.hovered ? textareaCtrl.Material.primaryTextColor : textareaCtrl.Material.hintTextColor)
        visible: opacity
    }
}
