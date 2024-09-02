import QtQuick
import QtQuick.Controls

Rectangle {
    id: titleBar
    x: 0
    y: 0
    height: 48
    width:bg.width
    color: "#00000000"
    property point winPos: Qt.point(0, 0)
    property bool isPinInScreen2:false;
    function mouseMove(x,y){
        if(isMouseIn(settingBtn,x,y)){
            settingBtn.color = "#28000000";
        } else {
            settingBtn.color = "#00000000";
        }
        if(isMouseIn(pin,x,y)){
            toolTip.text = "取消嵌入"
            toolTip.visible = true;
        }
    }
    function mouseDown(x,y){
        if(isMouseIn(settingBtn,x,y)){
            Qt.quit();
        }
        if(isMouseIn(pin,x,y)){
            if(!root.isInMainScreen){
                console.log("not in main screen");
                return;
            }
            embedHelper.Embed();
        }
    }
    Rectangle {
        id: settingBtn
        y:10
        height: 28
        width: 28
        anchors.right: parent.right
        anchors.rightMargin:10
        radius: 2
        color: "#00000000"
        antialiasing:true
        Text{
            color:skin.text1;
            font.family: fontLoader.name
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "\ue6e8"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = "#28000000";
            }
            onExited: {
                parent.color = "#00000000";
            }
            onClicked:{
                settingMenu.show();
            }
        }
    }
    Rectangle {
        id: pin
        y: 10
        height: 28
        width: 28
        anchors.right: settingBtn.left
        anchors.rightMargin:10
        radius: 2
        color: "#00000000"
        ToolTip {
            id:toolTip
            text: "嵌入"
            visible: false
            delay: 600
            timeout: 2000
            background: Rectangle {
                color: skin.toolTipBg
                radius: 4
            }
            contentItem: Text {
                text: toolTip.text
                color: skin.toolTipText
            }
        }
        Text{
            id:pinIcon
            color:skin.text1;
            font.family: fontLoader.name
            font.pixelSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "\ue70c"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                //if(isPinInScreen2 || embedHelper.IsEmbed()) return;
                if(embedHelper.IsEmbed()){
                    return;
                }
                toolTip.text = "嵌入"
                toolTip.visible = true;
                parent.color = "#28000000";
            }
            onExited: {
                //if(isPinInScreen2 || embedHelper.IsEmbed()) return;
                if(embedHelper.IsEmbed()) return;
                parent.color = "#00000000";
            }
            onClicked:{
                if(isPinInScreen2){
                    isPinInScreen2 = false;
                    return;
                }
                parent.color = "#28000000";
                if(!root.isInMainScreen){
                    //toolTip.visible = true
                    isPinInScreen2 = true
                    return;
                }
                embedHelper.Embed();
            }
        }
    }
    MouseArea {
        anchors.left: parent.left
        anchors.right: pin.left
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        height: parent.height
        onPressed: function(mouse){
            winPos.x = mouse.x;
            winPos.y = mouse.y;
        }
        onPositionChanged: function(mouse){
            if(isPinInScreen2){
                return;
            }
            if (pressedButtons === Qt.LeftButton) {
                root.x += mouse.x - winPos.x;
                root.y += mouse.y - winPos.y;
            }
        }
    }
}
