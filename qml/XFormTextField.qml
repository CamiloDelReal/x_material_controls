import QtQuick 2.14
import QtQuick.Templates 2.14 as T
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Material.impl 2.14

T.TextField {
    id: textfieldCtrl

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            placeholderCtrl ? placeholderCtrl.implicitWidth + leftPadding + rightPadding : 0)
                            || contentWidth + leftPadding + rightPadding
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             background ? background.implicitHeight : 0,
                             placeholderCtrl.implicitHeight + topPadding + bottomPadding)

    topPadding: 20
    bottomPadding: 10
    leftPadding: 1
    rightPadding: 1

    color: enabled ? Material.foreground : Material.hintTextColor
    selectionColor: Material.accentColor
    selectedTextColor: Material.primaryHighlightedTextColor
    verticalAlignment: TextInput.AlignBottom
    property alias backgroundOpacity: bgItemCtrl.opacity

    cursorDelegate: CursorDelegate { }

    PlaceholderText {
        id: placeholderCtrl
        x: textfieldCtrl.activeFocus || textfieldCtrl.text.length ? 0 : textfieldCtrl.leftPadding
        y: textfieldCtrl.activeFocus || textfieldCtrl.text.length ? ((textfieldCtrl.topPadding - placeholderCtrl.height) / 2) : textfieldCtrl.topPadding
        Behavior on x { NumberAnimation { duration: 100 } }
        Behavior on y { NumberAnimation { duration: 100 } }
        width: textfieldCtrl.width - (textfieldCtrl.leftPadding + textfieldCtrl.rightPadding)
        text: textfieldCtrl.placeholderText
        font.family: textfieldCtrl.font.family
        font.pixelSize: textfieldCtrl.activeFocus || textfieldCtrl.text.length ? 12 : textfieldCtrl.font.pixelSize
        Behavior on font.pixelSize { NumberAnimation { duration: 100 } }
        color: textfieldCtrl.activeFocus ? textfieldCtrl.Material.accent : textfieldCtrl.Material.hintTextColor
        verticalAlignment: textfieldCtrl.verticalAlignment
        elide: Text.ElideRight
        visible: textfieldCtrl.placeholderText.length
    }

    background: Rectangle {
        id: bgItemCtrl
        y: textfieldCtrl.height - height - (textfieldCtrl.bottomPadding * 0.45)
        implicitWidth: 120
        height: textfieldCtrl.activeFocus || textfieldCtrl.hovered ? 2 : 1
        color: textfieldCtrl.activeFocus ? textfieldCtrl.Material.accentColor
                                   : (textfieldCtrl.hovered ? textfieldCtrl.Material.primaryTextColor : textfieldCtrl.Material.hintTextColor)
        visible: opacity
    }
}
