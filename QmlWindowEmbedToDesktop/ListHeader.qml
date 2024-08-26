import QtQuick 2.15

Rectangle {
	width:parent.width
	height:32 
    color:"#00000000"
    Text{
        color:"#FF1F2329"
        font.pixelSize: 24
        anchors.verticalCenter: parent.verticalCenter
        text: "今天 7月19日"
    }
    Rectangle {
        anchors.right: parent.right
        width:parent.height
        height:parent.height
        color:"#00000000"
        radius:3
        Text{
            color:"#ff007AFF"
            font.pixelSize: 36
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "\u002b"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {
                parent.color = "#bbffffff";
            }
            onExited: {
                parent.color = "#00000000";
            }
            onPressed: {           
            }
        }
    }
}