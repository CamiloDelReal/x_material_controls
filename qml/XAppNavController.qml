import QtQuick 2.14
import QtQuick.Controls 2.14

import "qrc:/js/Queue.js" as Queue

StackView {
    id: navControllerCtrl

    property var viewToDestroy

    property bool isInitializing: false

    Component.onCompleted: {
        viewToDestroy = new Queue.Queue()
    }

    property var viewNavigationModel: undefined

    property alias splashViewSource: appSplashLoader.source
    property alias splashViewSourceComponent: appSplashLoader.sourceComponent

    function reinitialize() {
        startupTimer.start()
    }

    Loader {
        id: appSplashLoader
        active: true
        visible: false
        width: parent.width
        height: parent.height
        onLoaded: {
            // Show loading
            navControllerCtrl.initialItem = item

            // Start app and ui initialization
            startupTimer.start()
        }
    }

    Repeater {
        id: viewLoaderGenerator

        Loader {
            id: viewLoader
            active: false
            visible: false
            source: modelData.view
            onLoaded: {
                item.modelIndex = index
                navControllerCtrl.gotoView(index)
            }
        }
    }

    function initialization() {
        console.log("XAppNavController > initialization()")
    }

    function gotoView(viewIndex) {
        if(navControllerCtrl.currentItem.modelIndex !== viewIndex) {
            if(viewLoaderGenerator.itemAt(viewIndex).status === Loader.Ready) {
                if(viewLoaderGenerator.model[viewIndex].stacked) {
                    prepareCurrentForPushExit(navControllerCtrl.currentItem)
                    prepareNextForPushEnter(viewLoaderGenerator.itemAt(viewIndex).item)
                    navControllerCtrl.push(viewLoaderGenerator.itemAt(viewIndex).item)
                }
                else {
                    var currentItemIndex = navControllerCtrl.currentItem.modelIndex
                    prepareCurrentForReplaceExit(navControllerCtrl.currentItem)
                    prepareNextForReplaceEnter(viewLoaderGenerator.itemAt(viewIndex).item)
                    navControllerCtrl.replace(viewLoaderGenerator.itemAt(viewIndex).item)
                    //Send to clean
                    navControllerCtrl.viewToDestroy.enqueue(currentItemIndex)
                    cleanPendingViewsTimer.start()
                }
            }
            else {
                viewLoaderGenerator.itemAt(viewIndex).active = true
            }
        }
    }

    function returnFromView(viewIndex) {
        prepareCurrentForPopExit(navControllerCtrl.currentItem)
        prepareNextForPopEnter(navControllerCtrl.get(depth - 2, StackView.DontLoad))
        if(viewLoaderGenerator.model[viewIndex].stacked) {
            navControllerCtrl.pop()
        }
        //Send to clean
        navControllerCtrl.viewToDestroy.enqueue(viewIndex)
        cleanPendingViewsTimer.start()
    }

    function prepareCurrentForPushExit(item) {
    }
    function prepareNextForPushEnter(item) {
        if(item !== null) {
            item.opacity = 0.0
            item.scale = 0.8
        }
    }

    function prepareCurrentForPopExit(item) {
    }
    function prepareNextForPopEnter(item) {
    }

    function prepareCurrentForReplaceExit(item) {
    }
    function prepareNextForReplaceEnter(item) {
        if(item !== null) {
            item.opacity = 0.0
        }
    }

    pushEnter: Transition {
        ParallelAnimation {
            OpacityAnimator { from : 0; to : 1; duration : 100; easing.type: Easing.OutQuad }
            ScaleAnimator { from : 0.8; to : 1; duration : 100; easing.type: Easing.OutQuad }
        }
    }
    pushExit: Transition {
        OpacityAnimator { from : 1; to : 1; duration : 100; easing.type: Easing.OutQuad }
    }

    popEnter: Transition {
        OpacityAnimator { from : 1; to : 1; duration : 100; easing.type: Easing.OutQuad }
    }
    popExit: Transition {
        ParallelAnimation {
            OpacityAnimator { from : 1; to : 0; duration : 100; easing.type: Easing.OutQuad }
            ScaleAnimator { from : 1; to : 0.8; duration : 100; easing.type: Easing.OutQuad }
        }
    }

    replaceExit: Transition {
        OpacityAnimator { from : 1; to : 1; duration : 250; easing.type: Easing.OutQuad }
    }
    replaceEnter: Transition {
        OpacityAnimator { from: 0; to: 1; duration: 250; easing.type: Easing.OutQuad }
    }

    Timer {
        id: startupTimer
        interval: 100
        repeat: false
        onTriggered: {
            isInitializing = true

            //Prepare navigation
            if(navControllerCtrl.viewNavigationModel != undefined)
                viewLoaderGenerator.model = navControllerCtrl.viewNavigationModel

            // User initialization
            navControllerCtrl.initialization()

            isInitializing = false
        }
    }

    Timer {
        id: cleanPendingViewsTimer
        interval: 500
        repeat: false
        onTriggered: {
            while(navControllerCtrl.viewToDestroy.getLength() > 0) {
                var index = navControllerCtrl.viewToDestroy.dequeue()
                if(index === -1) {
                    appSplashLoader.active = false
                    navControllerCtrl.initialItem = null
                }
                else {
                    viewLoaderGenerator.itemAt(index).active = false
                }
            }
        }
    }
}
