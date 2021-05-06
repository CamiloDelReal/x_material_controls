import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

T.TextField {
    id: textfieldCtrl

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            placeholderCtrl ? placeholderCtrl.implicitWidth + leftPadding + rightPadding : 0)
                   || contentWidth + leftPadding + rightPadding
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             placeholderCtrl.implicitHeight + topPadding + bottomPadding)

    topPadding: 22
    bottomPadding: 8
    leftPadding: leftItemMargin + leftItemLayoutCtrl.implicitWidth + (leftItemLayoutCtrl.children.length ? spacing : 0)
    rightPadding: rightItemMargin + rightItemLayoutCtrl.implicitWidth + (rightItemLayoutCtrl.children.length ? spacing : 0)

    color: enabled ? Material.foreground : Material.hintTextColor
    selectionColor: Material.accentColor
    selectedTextColor: Material.primaryHighlightedTextColor
    verticalAlignment: TextInput.AlignBottom

    property int spacing: 8
    property double backgroundOpacity: 0.6
    property color backgroundColor: textfieldCtrl.Material.dividerColor
    property int backgroundBorder: 2
    property color backgroundBorderColor: textfieldCtrl.activeFocus
                                          ? textfieldCtrl.Material.accentColor
                                          : (textfieldCtrl.enabled
                                             ? (textfieldCtrl.hovered
                                                ? textfieldCtrl.Material.primaryTextColor
                                                : textfieldCtrl.Material.hintTextColor)
                                             : Material.hintTextColor)
    property int backgroundRadius: 4

    property alias leftItem: leftItemLayoutCtrl.children
    property int leftItemMargin: 8
    property alias rightItem: rightItemLayoutCtrl.children
    property int rightItemMargin: 8

    cursorDelegate: CursorDelegate { }

    Item {
        id: leftItemCtrl
        x: leftItemMargin
        y: (textfieldCtrl.contentHeight + topPadding + bottomPadding - leftItemLayoutCtrl.implicitHeight) / 2 + 6

        Row {
            id: leftItemLayoutCtrl
            anchors.left: parent.left
            anchors.top: parent.top
        }
    }

    Item {
        id: rightItemCtrl
        x: textfieldCtrl.width - rightItemLayoutCtrl.implicitWidth - rightItemMargin
        y: (textfieldCtrl.contentHeight + topPadding + bottomPadding - rightItemLayoutCtrl.implicitHeight) / 2 + 6

        Row {
            id: rightItemLayoutCtrl
            anchors.left: parent.left
            anchors.top: parent.top
        }
    }

    PlaceholderText {
        id: placeholderCtrl
        x: textfieldCtrl.activeFocus || textfieldCtrl.text.length ? 8 : textfieldCtrl.leftPadding
        y: textfieldCtrl.activeFocus || textfieldCtrl.text.length ? 2 : textfieldCtrl.topPadding - 2
        Behavior on x { NumberAnimation { duration: 100 } }
        Behavior on y { NumberAnimation { duration: 100 } }
        width: placeholderCtrl.implicitWidth
        text: textfieldCtrl.placeholderText
        font.family: textfieldCtrl.font.family
        font.pixelSize: textfieldCtrl.activeFocus || textfieldCtrl.text.length ? 12 : textfieldCtrl.font.pixelSize
        Behavior on font.pixelSize { NumberAnimation { duration: 100 } }
        color: textfieldCtrl.activeFocus
               ? textfieldCtrl.Material.accentColor
               : (textfieldCtrl.enabled
                  ?(textfieldCtrl.hovered && textfieldCtrl.text.length
                    ? textfieldCtrl.Material.primaryTextColor
                    : textfieldCtrl.Material.hintTextColor)
                  : Material.hintTextColor)
        verticalAlignment: textfieldCtrl.verticalAlignment
        elide: Text.ElideRight
        visible: textfieldCtrl.placeholderText.length
    }

    background: Item {
        id: bgItemCountainerCtrl
        implicitHeight: textfieldCtrl.implicitHeight
        implicitWidth: 120
        clip: true

        Rectangle {
            id: bgItemCtrl
            anchors.fill: parent
            anchors.bottomMargin: -16
            opacity: backgroundOpacity
            radius: backgroundRadius
            color: backgroundColor
        }

        Rectangle {
            id: bgBorderCtrl
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: backgroundBorder
            color: backgroundBorderColor
            visible: opacity
        }
    }

}
