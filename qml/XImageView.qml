import QtQuick 2.14

Item {
    id: imageView
    width: 640
    height: 360

    signal clicked

    property alias source: imageContent.source
    property alias asynchronous: imageContent.asynchronous

    property var resetAnimation: ParallelAnimation {
        running: false
        PropertyAnimation {
            target: flickArea
            property: "contentWidth"
            to: imageView.width
            duration: 200
        }
        PropertyAnimation {
            target: flickArea
            property: "contentHeight"
            to: imageView.height
            duration: 200
        }
        PropertyAnimation {
            target: flickArea
            properties: "contentX, contentY"
            to: 0
            duration: 200
        }
        PropertyAnimation {
            target: flickArea
            properties: "topMargin, rightMargin, bottomMargin, leftMargin"
            to: 0
            duration: 200
        }
    }

    Flickable {
        id: flickArea
        anchors.fill: parent
        contentWidth: imageView.width
        contentHeight: imageView.height
        leftMargin: rightMargin
//        boundsBehavior: Flickable.StopAtBounds

        PinchArea {
            anchors.fill: parent
            property real initialWidth
            property real initialHeight
            onPinchStarted: {
                initialWidth = flickArea.contentWidth
                initialHeight = flickArea.contentHeight
            }

            onPinchUpdated: {
                flickArea.contentX += pinch.previousCenter.x - pinch.center.x
                flickArea.contentY += pinch.previousCenter.y - pinch.center.y
                var newContentWidth = initialWidth * pinch.scale
                var newContentHeight = initialHeight * pinch.scale

                //Adjust Flickable margin to avoid extra spacings
                if(imageContent.width > flickArea.width) {
                    var horizontalMargins
                    if(imageContent.paintedWidth < flickArea.width) {
                        horizontalMargins = (imageContent.width - flickArea.width) / 2
                    }
                    else {
                        horizontalMargins = (imageContent.width - imageContent.paintedWidth) / 2
                    }
                    flickArea.leftMargin = -horizontalMargins
                    flickArea.rightMargin = -horizontalMargins
                }
                else {
                    flickArea.leftMargin = 0
                    flickArea.rightMargin = 0
                }
                if(imageContent.height > flickArea.height) {
                    var verticalMargins
                    if(imageContent.paintedHeight < flickArea.height) {
                        verticalMargins = (imageContent.height - flickArea.height) / 2
                    }
                    else {
                        verticalMargins = (imageContent.height - imageContent.paintedHeight) / 2
                    }

                    flickArea.topMargin = -verticalMargins
                    flickArea.bottomMargin = -verticalMargins
                }
                else {
                    flickArea.topMargin = 0
                    flickArea.bottomMargin = 0
                }
                flickArea.resizeContent(newContentWidth, newContentHeight, pinch.center)
            }

            onPinchFinished: {
                if(flickArea.contentWidth < imageView.width) {
                    flickArea.resizeContent(imageView.width, imageView.height, pinch.center)
                    flickArea.leftMargin = 0
                    flickArea.rightMargin = 0
                    flickArea.topMargin = 0
                    flickArea.bottomMargin = 0
                }

                flickArea.returnToBounds()
            }

            Item {
                id: imageContainer
                width: flickArea.contentWidth
                height: flickArea.contentHeight
                anchors.centerIn: parent

                Image {
                    id: imageContent
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: {
                            imageView.resetAnimation.running = true
                        }
                        onClicked: imageView.clicked()
                    }
                }
            }
        }
    }
}
