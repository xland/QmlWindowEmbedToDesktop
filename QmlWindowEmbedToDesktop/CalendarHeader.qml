import QtQuick
import QtQuick.Controls

Rectangle {
    color: "#00000000"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: titleBar.bottom
    anchors.topMargin: 3
    width:270
    height:40
    property string yearMonthText
    property int mouseInBtn:0
    function mouseMove(x,y){
        if(isMouseIn(goPreMonthBtn,x,y)){
            goPreMonthBtn.color = "#4bffffff";
            mouseInBtn = 1
        } else {
            goPreMonthBtn.color = "#00000000";
            mouseInBtn = 0
        }
        if(isMouseIn(goNextMonthBtn,x,y)){
            goNextMonthBtn.color = "#4bffffff";
            mouseInBtn = 2
        } else {
            goNextMonthBtn.color = "#00000000";
            mouseInBtn = 0
        }
    }
    function mouseDown(x,y){
        if(mouseInBtn === 0){
            return;
        }else if(mouseInBtn === 1){
            conn.send({msgType: 'EmbedCalendar',msgName: 'changePrevMonth'})
        }else if(mouseInBtn === 2){
            conn.send({msgType: 'EmbedCalendar',msgName: 'changeNextMonth'})
        }
    }
    component IconBtn: Rectangle {
        property string iconCode:"\ue709"
        property string toolTipText:"上个月"
        color: "#00000000"
        anchors.top: parent.top
        anchors.topMargin:4
        width:32
        height:32
        radius:32
        signal clicked()
        border {
            width: 0.6
            color: "#ff797B7F"
        }
        Text{
            color:"#ff4C4F54"
            font.family: fontLoader.name
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: iconCode
        }
        ToolTip {
            id:toolTip
            text: toolTipText
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
        MouseArea {
            id:mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = "#4bffffff";
            }
            onExited: {
                parent.color = "#00000000";
            }
            onPressed: {
                parent.clicked();
            }
        }
    }
    IconBtn {
        id:goPreMonthBtn
        anchors.left: parent.left
        onClicked: {
            conn.send({msgType: 'EmbedCalendar',msgName: 'changePrevMonth'})
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
            text: yearMonthText
        }
    }
    IconBtn {
        id:goNextMonthBtn
        anchors.right: parent.right
        iconCode:"\ue746"
        toolTipText:"下个月"
        onClicked: {
            conn.send({msgType: 'EmbedCalendar',msgName: 'changeNextMonth'})
        }
    }
}