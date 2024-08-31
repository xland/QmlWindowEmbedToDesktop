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
            text: "新建日程"
            visible: mouseArea.containsMouse
            delay: 500 // 延迟显示工具提示的时间（以毫秒为单位）
            timeout: 5000 // 工具提示显示的时间（以毫秒为单位）
        }
        Text{
            color:"#ff007AFF"
            font.pixelSize: 36
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "\u002b"
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