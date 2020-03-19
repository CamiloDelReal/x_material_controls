import QtQuick 2.14
import QtQuick.Controls 2.14

SwipeView {
    id: swipeCtrl

    property alias moving: listCtrl.moving
    property alias layoutDirection: listCtrl.layoutDirection

    contentItem: ListView {
        id: listCtrl
        model: swipeCtrl.contentModel
        interactive: swipeCtrl.interactive
        currentIndex: swipeCtrl.currentIndex

        spacing: swipeCtrl.spacing
        orientation: swipeCtrl.orientation
        snapMode: ListView.SnapOneItem
        boundsBehavior: Flickable.StopAtBounds

        highlightRangeMode: ListView.StrictlyEnforceRange
        preferredHighlightBegin: 0
        preferredHighlightEnd: 0
        highlightMoveDuration: 250
    }
}
