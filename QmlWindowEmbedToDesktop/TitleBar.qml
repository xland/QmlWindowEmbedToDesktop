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
        if(embedHelper.IsEmbed()) return;
        if(isMouseIn(pin,x,y)){
            pin.color = "#28000000";
        } else {
            pin.color = "#00000000";
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
            color:"#FF646A73";
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
                Qt.quit();
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
            text: "无法在副屏上把窗口置于桌面图标之下 \n 除此之外，其他功能都可正常使用"
            visible: false
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
            id:pinIcon
            color:"#FF646A73";
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
                if(isPinInScreen2 || embedHelper.IsEmbed()) return;
                parent.color = "#28000000";
            }
            onExited: {
                if(isPinInScreen2 || embedHelper.IsEmbed()) return;
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
