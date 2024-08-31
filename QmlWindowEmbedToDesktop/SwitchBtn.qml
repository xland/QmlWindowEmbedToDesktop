import QtQuick

Rectangle {
    id:switchBtn
    function mouseMove(x,y){
        if(isMouseIn(switchBtn,x,y)){
            switchBtn.color = "#BBFFFFFF";
        } else {
            switchBtn.color = "#00000000";
        }
    }
    function mouseDown(x,y){
        if(isMouseIn(switchBtn,x,y)){
            switchList();
        }
    }
    function switchList(){
        list.visible = !list.visible;
        if(list.visible){
            console.log("/n !!!!!!!!!!!!!!!!!!!!!!!!!!!!!",listBody.totalHeight)
            root.height = Math.min(860, 580+listBody.totalHeight+60);
            showJobIcon.text = "\ue708"
        }else{
            root.height = 580;
            showJobIcon.text = "\ue70f"
        }
        switchBtn.color = "#00000000";
        embedHelper.WinResized();
    }
    anchors.right:bg.right
    anchors.rightMargin:26
    height:42
    width:120
    color:"#00000000"
    anchors.bottom: bg.bottom
    anchors.bottomMargin:18
    radius:3
    Text {
        id:showJobText
        color:"#FF007AFF"
        font.pixelSize: 20
        anchors.left:parent.left
        anchors.leftMargin:8
        anchors.verticalCenter: parent.verticalCenter
        text: "显示日程"
    }
    Text {
        id:showJobIcon
        font.family: fontLoader.name
        color:"#FF007AFF"
        font.pixelSize: 20
        anchors.left:showJobText.right
        anchors.leftMargin:4
        anchors.verticalCenter: parent.verticalCenter
        text: "\ue70f"
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            parent.color = "#BBFFFFFF";
        }
        onExited: {
            parent.color = "#00000000";
        }
        onPressed: {
            switchList();
        }
    }
}