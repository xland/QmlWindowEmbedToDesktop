import QtQuick
import QtQuick.Controls

Rectangle {
    function mouseMove(x,y){
        if(isMouseIn(addBtn,x,y)){
            addBtn.color = "#BBFFFFFF";
        } else {
            addBtn.color = "#00000000";
        }
    }
    function mouseDown(x,y){
        if(isMouseIn(addBtn,x,y)){
            conn.send({ msgType: 'EmbedCalendar',msgName: 'createSchedule'})
        }
    }
	width:parent.width
	height:32 
    color:"#00000000"
    property string todayStr:""
    Text{
        color:"#FF1F2329"
        font.pixelSize: 24
        anchors.verticalCenter: parent.verticalCenter
        text: todayStr
    }
    Rectangle {
        id:addBtn
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
                conn.send({ msgType: 'EmbedCalendar',msgName: 'createSchedule'})
            }
        }
    }
}