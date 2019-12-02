import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/js/Queue.js" as Queue

StackView {
    id: navControllerCtrl

    property var viewToDestroy

    Component.onCompleted: {
        viewToDestroy = new Queue.Queue()
    }

    property alias initialView: navControllerCtrl.initialItem
    property alias viewNavigationModel: viewLoaderGenerator.model

    Repeater {
        id: viewLoaderGenerator

        Loader {
            id: viewLoader
            active: false
            visible: false
            source: modelData.view
            property var sharedData: undefined
            onLoaded: {
                item.modelIndex = index
                navControllerCtrl.gotoView(index)
            }
        }
    }

    function gotoView(viewIndex, properties) {
        if(!navControllerCtrl.currentItem || navControllerCtrl.currentItem.modelIndex !== viewIndex) {
            if(viewLoaderGenerator.itemAt(viewIndex).status === Loader.Ready) {
                if(viewLoaderGenerator.model[viewIndex].stacked) {
                    prepareCurrentForPushExit(navControllerCtrl.currentItem)
                    prepareNextForPushEnter(viewLoaderGenerator.itemAt(viewIndex).item)
                    navControllerCtrl.push(viewLoaderGenerator.itemAt(viewIndex).item)
                }
                else {
                    var currentItemIndex = undefined
                    if(navControllerCtrl.currentItem) {
                        currentItemIndex = navControllerCtrl.currentItem.modelIndex
                        prepareCurrentForReplaceExit(navControllerCtrl.currentItem)
                    }
                    prepareNextForReplaceEnter(viewLoaderGenerator.itemAt(viewIndex).item)
                    navControllerCtrl.replace(viewLoaderGenerator.itemAt(viewIndex).item,
                                              viewLoaderGenerator.itemAt(viewIndex).sharedData)
                    //Send to clean
                    if(currentItemIndex != undefined) {
                        navControllerCtrl.viewToDestroy.enqueue(currentItemIndex)
                        cleanPendingViewsTimer.start()
                    }
                }
            }
            else {
                viewLoaderGenerator.itemAt(viewIndex).sharedData = properties
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

    function goBack() {
        prepareCurrentForPopExit(navControllerCtrl.currentItem)
        prepareNextForPopEnter(navControllerCtrl.get(depth - 2, StackView.DontLoad))
        var page = pop()
        //Send to clean
        navControllerCtrl.viewToDestroy.enqueue(page.modelIndex)
        cleanPendingViewsTimer.start()
    }

    function prepareCurrentForPushExit(item) {
    }
    function prepareNextForPushEnter(item) {
    }

    function prepareCurrentForPopExit(item) {
    }
    function prepareNextForPopEnter(item) {
    }

    function prepareCurrentForReplaceExit(item) {
    }
    function prepareNextForReplaceEnter(item) {
    }

    Timer {
        id: cleanPendingViewsTimer
        interval: 500
        repeat: false
        onTriggered: {
            while(navControllerCtrl.viewToDestroy.getLength() > 0) {
                var index = navControllerCtrl.viewToDestroy.dequeue()
                if(index === -1) {
                }
                else {
                    viewLoaderGenerator.itemAt(index).active = false
                }
            }
        }
    }
}
