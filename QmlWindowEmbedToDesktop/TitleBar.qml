import QtQuick
import QtQuick.Controls 2.15

Rectangle {
    x: 0
    y: 0
    height: 48
    width:bg.width
    color: "#00000000"
    property point winPos: Qt.point(0, 0)
    function mouseMove(x,y){
        if(isMouseIn(settingBtn,x,y)){
            settingBtn.color = "#28000000";
        } else {
            settingBtn.color = "#00000000";
        }
        if(isMouseIn(pin,x,y)){
            pin.color = "#28000000";
        } else {
            pin.color = "#00000000";
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
            color:"#ff646A73";
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
        Text{
            id:pinIcon
            color:"#ff646A73";
            font.family: fontLoader.name
            font.pixelSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "\uf08d"
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
                if(pinIcon.text == "\uf08d"){
                    embedHelper.Embed();
                    pinIcon.text = "\ue68f"
                }else{
                    embedHelper.UnEmbed();
                    pinIcon.text = "\uf08d"
                }
            }
        }
    }
    MouseArea {
        anchors.left: parent.left
        anchors.right: pin.left
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
