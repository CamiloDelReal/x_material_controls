import QtQuick
import QtQuick.Controls

Item {
    id: behaviorController

    enum ScrollOrder {
        TopToBottom,
        BottomToTop
    }

    enum ScrollType {
        PullBack,
        Inline
    }

    property int order: XScrollingBehavior.ScrollOrder.BottomToTop
    property int type: XScrollingBehavior.ScrollType.PullBack

    onOrderChanged: {
        prepareTopbar()
    }

    onTypeChanged: {
        prepareTopbar()
    }

    /* TopBar ****************************************************************/

    property int hiddenTopBarsHeight: 0
    property var hiddenTopBars: undefined
    onHiddenTopBarsChanged: {
        calculateHiddenTopBarsHeight()
    }

    function calculateHiddenTopBarsHeight() {
        hiddenTopBarsHeight = 0
        if (hiddenTopBars && hiddenTopBars.length !== undefined) {
            for(var i = 0; i < hiddenTopBars.length; i++) {
                hiddenTopBarsHeight += hiddenTopBars[i].height > 0
                        ? hiddenTopBars[i].height
                        : hiddenTopBars[i].implicitHeight
            }

            if(topbar) {
                hiddenTopBarsHeight += topbar.topPadding + topbar.bottomPadding
                prepareTopbar()
            }
        }
    }

    property var topBarsHeightSum: []

    property int starterY: 0
    property Item topbar: null
    onTopbarChanged: {
        prepareTopbar()
    }

    function prepareTopbar() {
        if(topbar) {
            calculateTopbarHeight()
            topbar.y = starterY
        }

        if(flickable) {
            prepareFlickable()
        }
        if(scrollIndicator) {
            prepareScrollIndicator()
        }
    }

    function calculateTopbarHeight() {
        var topbarHeight = 0
        for(var i = 0; i < topbar.contentChildren.length; i++) {
            topbarHeight += topbar.contentChildren[i].height > 0
                    ? topbar.contentChildren[i].height
                    : topbar.contentChildren[i].implicitHeight

            var barMargin = 0
            if(i < (topbar.contentChildren.length - 1)) {
                for(var j = (i + 1); j < (topbar.contentChildren.length); j++) {
                    barMargin += (topbar.contentChildren[j].height > 0
                                  ? topbar.contentChildren[j].height
                                  : topbar.contentChildren[j].implicitHeight)
                }
                topBarsHeightSum.push(barMargin)
            }
            topbar.contentChildren[i].anchors.bottom = topbar.contentChildren[i].parent.bottom
            topbar.contentChildren[i].anchors.bottomMargin = barMargin
        }

        topbar.height = topbarHeight + topbar.topPadding + topbar.bottomPadding
    }

    Repeater {
        model: (topbar && hiddenTopBars && hiddenTopBars.length !== undefined)
               ? (topbar.contentChildren.length - 1)
               : 0

        Item {
            Connections {
                target: topbar
                function onYChanged() {
                    var value = (order === XScrollingBehavior.ScrollOrder.BottomToTop
                                 ? Math.max(topbar.y + topBarsHeightSum[index] - starterY, 0)
                                 : topBarsHeightSum[index])
                    topbar.contentChildren[index].anchors.bottomMargin = value
                }
            }
        }
    }

    /* End TopBar ************************************************************/


    /* Flickable *************************************************************/

    property Flickable flickable: null
    onFlickableChanged: {
        prepareFlickable()
    }

    function prepareFlickable() {
        if(flickable && topbar) {
            flickable.topMargin = topbar.height + starterY
            if(flickable.hasOwnProperty("displayMarginBeginning")) {
                flickable.displayMarginBeginning = topbar.height + starterY + 100
            }

            var initialY = topbar.height
            if(flickable.hasOwnProperty("headerItem") && flickable.headerItem !== null) {
                initialY += (flickable.headerItem.height > 0
                             ? flickable.headerItem.height
                             : flickable.headerItem.implicitHeight)
            }
            flickable.contentY = -initialY
            flickable.contentItem.y = initialY
        }
    }

    /* End Flickable *********************************************************/


    /* ScrollIndicator *******************************************************/

    property ScrollIndicator scrollIndicator: null
    onScrollIndicatorChanged: {
        prepareScrollIndicator()
    }

    function prepareScrollIndicator() {
        if(topbar && scrollIndicator && scrollIndicator.hasOwnProperty("topPadding")) {
            scrollIndicator.topPadding = topbar.height + topbar.y
            topbar.onYChanged.connect(updateScrollIndicatorProperties)
        }
    }

    function updateScrollIndicatorProperties() {
        scrollIndicator.topPadding = topbar.height + topbar.y
    }

    /* End ScrollIndicator ***************************************************/


    /* TopBar Behaviors ******************************************************/

    Loader {
        id: pullBackTopBehaviorLoader
        visible: false
        active: (type === XScrollingBehavior.ScrollType.PullBack
                 && flickable && topbar && hiddenTopBars !== undefined && hiddenTopBars.length !== undefined)

        sourceComponent: QtObject {
            property real previousY
            property Flickable previousFlickable: null

            Component.onCompleted: {
                disconnectFlickable()
                connectFlickable()
            }

            Component.onDestruction: {
                disconnectFlickable()
            }

            function disconnectFlickable() {
                if (previousFlickable) {
                    previousY = 0
                    previousFlickable.contentItem.yChanged.disconnect(yChanged)
                    previousFlickable.interactiveChanged.disconnect(interactiveChanged)
                    previousFlickable = null
                }
            }

            function connectFlickable() {
                if (flickable) {
                    previousY = -(flickable.contentItem.y)
                    flickable.contentItem.yChanged.connect(yChanged)
                    flickable.interactiveChanged.connect(interactiveChanged)
                    previousFlickable = flickable
                }
            }

            function clamp(x, min, max) {
                if (min <= max) {
                    return Math.max(min, Math.min(x, max));
                } else {
                    return clamp(x, max, min);
                }
            }

            function yChanged() {
                if ((!flickable.atYBeginning && !flickable.atYEnd)) {
                    var deltaY = -(flickable.contentItem.y) - previousY

                    var newY = clamp(Math.ceil(topbar.y - deltaY),
                                     -(hiddenTopBarsHeight - starterY), starterY)
                    if(deltaY > -0.7 || deltaY < 0.7) {
                        topbar.y -= deltaY
                        if(deltaY > 0) {
                            if(topbar.y < -(hiddenTopBarsHeight - starterY)) {
                                topbar.y = -(hiddenTopBarsHeight - starterY)
                            }
                        } else {
                            if(topbar.y > starterY) {
                                topbar.y = starterY
                            }
                        }
                    } else {
                        topbar.y = newY
                    }
                }

                previousY = -(flickable.contentItem.y)
            }

            function interactiveChanged() {
                if (flickable && flickable.interactive)  {
                    topbar.y = starterY
                }
            }
        }
    }

    Loader {
        id: inlineTopBehaviorLoader
        active: (type === XScrollingBehavior.ScrollType.Inline
                 && flickable && topbar && hiddenTopBars !== undefined && hiddenTopBars.length !== undefined)

        sourceComponent: AnimationController{
            id: animationController
            animation: ParallelAnimation {
                NumberAnimation {
                    target: topbar
                    property: "y"
                    from: starterY
                    to: -(hiddenTopBarsHeight - starterY)
                    onToChanged: animationController.reload()
                }
            }
            progress: (1 - (flickable.contentItem.y -(topbar.height - hiddenTopBarsHeight + starterY)) / (hiddenTopBarsHeight))
        }
    }

    /* End TopBar Behaviors **************************************************/
}
