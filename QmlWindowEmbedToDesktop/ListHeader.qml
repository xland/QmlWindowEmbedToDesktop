import QtQuick
import QtQuick.Controls

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
        ToolTip {
            id:toolTip
            text: "新建日程"
            visible: mouseArea.containsMouse
            delay: 600
            timeout: 6000
            background: Rectangle {
                color: "#FF1A1A1A"
                radius: 4
            }
            contentItem: Text {
                text: toolTip.text
                color: "#FFFFFFFF"
            }
        }
        Text{
            color:"#ff007AFF"
            font.family: fontLoader.name
            font.pixelSize: 22
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "\ue70b"
        }
        MouseArea {
            id:mouseArea
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