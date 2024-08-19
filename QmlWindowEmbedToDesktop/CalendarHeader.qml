import QtQuick

Rectangle {
    color: "#00000000"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: titleBar.bottom
    anchors.topMargin: 3
    width:270
    height:40
    Rectangle {
        id:goPreMonthBtn
        color: "#00000000"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin:4
        width:32
        height:32
        radius:32
        border {
            width: 1
            color: "#ff797B7F"
        }
        Text{
            color:"#ff4C4F54"
            font.family: fontLoader.name
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "\uf053"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = "#4bffffff";
            }
            onExited: {
                parent.color = "#00000000";
            }
        }
    }
    Rectangle {
        anchors.left: goPreMonthBtn.right
        anchors.right: goNextMonthBtn.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "#00000000"
        Text{
            color:"#FF1F2329"
            font.pixelSize: 28
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "2024年8月"
        }
    }
    Rectangle {
        id:goNextMonthBtn
        color: "#00000000"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin:4
        width:32
        height:32
        radius:32
        border {
            width: 1
            color: "#ff797B7F"
        }
        Text{
            color:"#ff4C4F54"
            font.family: fontLoader.name
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "\uf054"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = "#4bffffff";
            }
            onExited: {
                parent.color = "#00000000";
            }
        }
    }
}