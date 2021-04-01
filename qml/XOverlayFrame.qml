import QtQuick

Rectangle {
    id: overlayCtrl
    color: "#64303030"
    opacity: 1.0
    visible: opacity > 0

    property int elevation: 10
    property alias topVisible: top.visible
    property alias rightVisible: right.visible
    property alias bottomVisible: bottom.visible
    property alias leftVisible: left.visible

    Behavior on opacity { NumberAnimation { duration: 250 } }

    Rectangle {
        id: top
        height: overlayCtrl.elevation
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        gradient: Gradient {
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0.15)
                position: 0
            }
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0.05)
                position: 0.5
            }
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0)
                position: 1
            }
        }
    }

    Rectangle {
        id: right
        width: parent.height
        height: overlayCtrl.elevation
        rotation: 90
        anchors.left: parent.right
        transformOrigin: Item.TopLeft

        gradient: Gradient {
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0.15)
                position: 0
            }
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0.05)
                position: 0.5
            }
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0)
                position: 1
            }
        }
    }

    Rectangle {
        id: bottom
        height: overlayCtrl.elevation
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        gradient: Gradient {
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0.15)
                position: 1
            }
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0.05)
                position: 0.5
            }
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0)
                position: 0
            }
        }
    }

    Rectangle {
        id: left
        width: parent.height
        height: overlayCtrl.elevation
        rotation: 90
        anchors.left: parent.left
        anchors.bottom: parent.top
        transformOrigin: Item.BottomLeft

        gradient: Gradient {
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0.15)
                position: 1
            }
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0.05)
                position: 0.5
            }
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0)
                position: 0
            }
        }
    }
}
