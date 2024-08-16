import QtQuick

Rectangle {
    x: 0
    y: 0
    height: 28
    color: "#00000000"
    FontLoader {
        id: faLoader
        source: "fa-solid-900.ttf"
    }
    Rectangle {
        id: settingBtn
        y: 0
        height: parent.height
        width: 32
        anchors.right: parent.right
        color: "#00000000"
        radius: [0, 6, 0, 0]
        Text{
            color:"#ff000000";
            font.family: faLoader.name
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "\uf141"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = "#66000000";
            }
            onExited: {
                parent.color = "#00000000";
            }
        }
    }
    Rectangle {
        id: pinBtn
        y: 0
        height: parent.height
        width: 32
        anchors.right: settingBtn.left
        color: "#00000000"
        radius: [0, 6, 0, 0]
        Text{
            color:"#ff000000";
            font.family: faLoader.name
            font.pixelSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "\uf08d"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = "#66000000";
            }
            onExited: {
                parent.color = "#00000000";
            }
        }
    }
    MouseArea {
        anchors.left: parent.left
        anchors.right: pinBtn.left
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        height: parent.height
        onPressed: {
            winPos.x = mouse.x;
            winPos.y = mouse.y;
        }
        onPositionChanged: {
            if (pressedButtons === Qt.LeftButton) {
                root.x += mouse.x - winPos.x;
                root.y += mouse.y - winPos.y;
            }
        }
    }
}
