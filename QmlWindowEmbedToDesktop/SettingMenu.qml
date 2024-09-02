import QtQuick 2.3

Rectangle {
    id:settingMenu
    function show(){
        if(settingMenu.visible){
            return;
        }
        settingMenu.visible = true;
        timer.start()
    }
    width: 108
    height: 136
    y:38
    anchors.right:parent.right    
    anchors.rightMargin: 10
    color: "#EDEEEE"
    z:666
    radius:4
    visible:false    
    Timer {
        id: timer
        interval: 2000
        running: false 
        repeat: false  
        onTriggered: {
            if(mouseArea0.containsMouse || mouseArea1.containsMouse ||
                mouseArea2.containsMouse || mouseArea3.containsMouse){
                timer.start()
            }else{
                settingMenu.visible = false;
            }
        }
    }
    Rectangle{
        id:setting
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.top: parent.top
        anchors.topMargin: 4
        height:32
        radius:4
        color:"#00000000"
        Text {
            anchors.centerIn: parent
            text: "设置"
        }
        MouseArea {
            id:mouseArea0
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {
                parent.color = "#E0E0E0";
                settingMenu.hoverTime = Date.now();
            }
            onExited: {
                parent.color = "#00000000";
            }
            onPressed: {
                settingMenu.visible = false;
                Qt.openUrlExternally("http://moa.hikvision.com.cn/abouthiklink/index.html#/")
            }
        }
    }
    Rectangle{
        id:help
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.top: setting.bottom
        height:32
        radius:4
        color:"#00000000"
        Text {
            anchors.centerIn: parent
            text: "帮助中心"
        }
        MouseArea {
            id:mouseArea1
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {
                parent.color = "#E0E0E0";
                settingMenu.hoverTime = Date.now();
            }
            onExited: {
                parent.color = "#00000000";
            }
            onPressed: {
                settingMenu.visible = false;
                Qt.openUrlExternally("http://moa.hikvision.com.cn/abouthiklink/index.html#/")
            }
        }
    }
    Rectangle{
        id:advise
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.top: help.bottom
        height:32
        radius:4
        color:"#00000000"
        Text {
            anchors.centerIn: parent
            text: "建议反馈"
        }
        MouseArea {
            id:mouseArea2
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {
                parent.color = "#E0E0E0";
                settingMenu.hoverTime = Date.now();
            }
            onExited: {
                parent.color = "#00000000";
            }
            onPressed: {
                settingMenu.visible = false;
                Qt.openUrlExternally("http://moa.hikvision.com.cn/abouthiklink/index.html#/")
            }
        }
    }
    Rectangle{
        id:quit
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.top: advise.bottom
        height:32
        radius:4
        color:"#00000000"
        Text {
            anchors.centerIn: parent
            text: "退出"
        }
        MouseArea {
            id:mouseArea3
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {
                parent.color = "#E0E0E0";
                settingMenu.hoverTime = Date.now();
            }
            onExited: {
                parent.color = "#00000000";
            }
            onPressed: {
                Qt.quit();
            }
        }
    }
}
