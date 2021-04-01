import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
Page {
    id: onBoardingCtrl
    padding: 0

    property bool isPortrait: height >= width

    signal finish()

    state: "welcome"
    states: [
        State {
            name: "welcome"
            when: (slideContainerCtrl.currentIndex == 0)
            PropertyChanges { target: nextBtnCtrl; text: qsTr("Continue") }
            PropertyChanges { target: skipBtnCtrl; enabled: true; opacity: 1 }
        },
        State {
            name: "presentation"
            when: (slideContainerCtrl.currentIndex > 0 && slideContainerCtrl.currentIndex < (slideContainerCtrl.count - 1))
            PropertyChanges { target: nextBtnCtrl; text: qsTr("Next") }
            PropertyChanges { target: skipBtnCtrl; enabled: true; opacity: 1 }
        },
        State {
            name: "finish"
            when: (slideContainerCtrl.currentIndex == (slideContainerCtrl.count - 1))
            PropertyChanges { target: nextBtnCtrl; text: qsTr("Start") }
            PropertyChanges { target: skipBtnCtrl; enabled: false; opacity: 0 }
        }
    ]

    property var presentationModel: [
        {
            "title": qsTr("First Slide"),
            "image": "qrc:/img/unknow-picture-light.svg",
            "description": qsTr("Description description description description description")
        },
        {
            "title": qsTr("Second Slide"),
            "image": "qrc:/img/unknow-picture-light.svg",
            "description": qsTr("Description description description description description")
        },
        {
            "title": qsTr("Third Slide"),
            "image": "qrc:/img/unknow-picture-light.svg",
            "description": qsTr("Description description description description description")
        },
        {
            "title": qsTr("Fourth Slide"),
            "image": "qrc:/img/unknow-picture-light.svg",
            "description": qsTr("Description description description description description")
        }
    ]

    SwipeView {
        id: slideContainerCtrl
        anchors.fill: parent

        Repeater {
            model: presentationModel

            Loader {
                property string title: modelData.title
                property string image: modelData.image
                property string description: modelData.description

                sourceComponent: Item {
                    width: slideContainerCtrl.width
                    height: slideContainerCtrl.height

                    GridLayout {
                        id: grid
                        anchors.fill: parent
                        anchors.margins: 20
                        columnSpacing: 0
                        rowSpacing: 0
                        columns: onBoardingCtrl.isPortrait ? 1 : 3
                        rows: onBoardingCtrl.isPortrait ? 3 : 4

                        XDisplayLabel1 {
                            id: titleLabelPortraitCtrl
                            text: modelData.title
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Label.WordWrap
                            font.pixelSize: 30
                            padding: 12
                            Layout.columnSpan: onBoardingCtrl.isPortrait ? 1 : 3
                            Layout.fillWidth: true
                            Layout.preferredHeight: onBoardingCtrl.isPortrait
                                                    ? grid.height * 0.33
                                                    : grid.height * 0.25
                            Layout.rowSpan: 1
                        }

                        Item {
                            id: imgPortraitBackground
                            Layout.preferredHeight: onBoardingCtrl.isPortrait
                                                    ? grid.height * 0.38
                                                    : grid.height * 0.75
                            Layout.preferredWidth: onBoardingCtrl.isPortrait
                                                   ? grid.width
                                                   : grid.width * 0.33
                            Layout.columnSpan: 1
                            Layout.rowSpan: onBoardingCtrl.isPortrait ? 1 : 3

                            Rectangle {
                                anchors.centerIn: parent
                                width: Math.min(parent.width, parent.height)
                                height: width
                                color: modelData.hasOwnProperty("imageBackground")
                                       ? modelData.imageBackground
                                       : "transparent"
                                radius: modelData.hasOwnProperty("imageBackgroundRadius")
                                        ? modelData.imageBackgroundRadius
                                        : 0

                                Image {
                                    id: imgPortraitCtrl
                                    anchors.centerIn: parent
                                    source: modelData.image
                                    sourceSize.width: parent.width
                                                      - (modelData.hasOwnProperty("imageMargins")
                                                         ? (2 * modelData.imageMargins)
                                                         : 0)
                                    sourceSize.height: parent.width
                                                       - (modelData.hasOwnProperty("imageMargins")
                                                          ? (2 * modelData.imageMargins)
                                                          : 0)
                                }
                            }
                        }

                        XSubheadingLabel {
                            id: descriptionLabelPortraitCtrl
                            text: modelData.description
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Label.WordWrap
                            padding: 20
                            Layout.columnSpan: onBoardingCtrl.isPortrait ? 1 : 2
                            Layout.fillWidth: true
                            Layout.rowSpan: onBoardingCtrl.isPortrait ? 1 : 3
                            Layout.fillHeight: true
                        }
                    }
                }
            }
        }
    }

    footer: XToolBar {
        id: buttonBarCtrl
        leftPadding: 4
        topPadding: 0
        rightPadding: 4
        bottomPadding: 0

        ToolButton {
            id: skipBtnCtrl
            text: qsTr("Skip")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            implicitWidth: 80
            onClicked: onBoardingCtrl.finish()
            Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
        }

        XPageIndicator {
            id:indicatorCtrl
            anchors.centerIn: parent

            count: slideContainerCtrl.count
            currentIndex: slideContainerCtrl.currentIndex

            anchors.horizontalCenter: parent.horizontalCenter
        }

        ToolButton {
            id: nextBtnCtrl
            text: qsTr("Next")
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            implicitWidth: 90
            Behavior on text {
                SequentialAnimation {
                    NumberAnimation { target: nextBtnCtrl.contentItem; property: "opacity"; to: 0; duration: 100; easing.type: Easing.InOutQuad }
                    PropertyAction {}
                    NumberAnimation { target: nextBtnCtrl.contentItem; property: "opacity"; to: 1; duration: 100; easing.type: Easing.InOutQuad }
                }
            }
            onClicked: {
                if(slideContainerCtrl.currentIndex < (slideContainerCtrl.count - 1))
                    slideContainerCtrl.currentIndex = (slideContainerCtrl.currentIndex + 1)
                else
                    onBoardingCtrl.finish()
            }
        }

    }

}
