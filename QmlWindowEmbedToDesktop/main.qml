import QtQuick
import QtQuick.Controls
import QtQuick.Window


Window {
    id:root
    flags: Qt.FramelessWindowHint
    color: "#00000000"
    visible: true
    width: 580
    height: 580  //580,860
    x: 20
    y: 20
    title: "QtEmbededWindow"
    function isMouseIn(ele,x,y){
        let pos = ele.mapToItem(null, 0, 0);
        let flag = (x>pos.x && x < pos.x+ele.width && y>pos.y && y<pos.y+ele.height)
        return flag;
    }
    function wheelFunc(flag,x,y){
        listBody.wheelFunc(flag,x,y);
    }
    function moveFunc(x,y){
        titleBar.mouseMove(x,y)
        calendarHeader.mouseMove(x,y)
        calendarBody.mouseMove(x,y)
        switchBtn.mouseMove(x,y)
        listBody.mouseMove(x,y)
    }
    function downFunc(x,y){
        titleBar.mouseDown(x,y)
        listBody.mouseDown(x,y)
        calendarHeader.mouseDown(x,y)
        switchBtn.mouseDown(x,y)
        listBody.mouseDown(x,y)
    }
    function upFunc(x,y){
        listBody.mouseUp(x,y)
    }
    function updateScreenInfo() {
        if(isFirst < 2){ 
            isFirst += 1
            return;
        }
        if (screenPixelRatio < 0) {
            screenPixelRatio = screen.devicePixelRatio
            console.log(222222);
        }else if(screenPixelRatio != screen.devicePixelRatio){
            width = width/screenPixelRatio*screen.devicePixelRatio
            height = height/screenPixelRatio*screen.devicePixelRatio
            screenPixelRatio = screen.devicePixelRatio
            isInMainScreen = !isInMainScreen;
            console.log(111111);
        }
    }
    property real screenPixelRatio:-1.0;
    property bool isInMainScreen:true;
    property int isFirst:-2;
    onXChanged:updateScreenInfo();
    onYChanged:updateScreenInfo();
    FontLoader {
        id: fontLoader
        source: "iconfont.ttf"
    }
    Rectangle {
        id: bg
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        radius: 4
        color: "#BBEEEEEE"  
        antialiasing:true
        border {
            width: 0.5
            color: "#88797B7F"
        }
        TitleBar {
            id: titleBar
        }
        CalendarHeader {
            id: calendarHeader
        }
        Rectangle {
            id:body
            anchors.top: calendarHeader.bottom
            anchors.topMargin:6
            anchors.left: bg.left
            anchors.right: bg.right
            anchors.leftMargin:14
            anchors.rightMargin:14
            height:412            
            color:"#00000000"
            WeekHeader {
                id: weekHeader
            }  
            CalendarBody {
                id: calendarBody
            }
        }
        Rectangle {
            id:list
            anchors.top: body.bottom
            anchors.topMargin:16
            anchors.left: bg.left
            anchors.right: bg.right
            anchors.leftMargin:34
            anchors.rightMargin:34
            anchors.bottom: switchBtn.top
            anchors.bottomMargin:12
            visible:false            
            color:"#00000000"
            ListHeader{
                id: listHeader
            }
            ListBody{
                id: listBody
            }
        }
        SwitchBtn {
            id: switchBtn
        }
    }
    ToolTip{
        id:toolTip
    }
    Conn{
        id:conn    
    }
    Timer {
        id: timeoutTimer
        interval: 1000  // 设置超时时间为1000毫秒（1秒）
        running: false  // 初始状态为不运行
        repeat: false   // 只执行一次
        onTriggered: {
            console.log("Timeout reached!",screen.devicePixelRatio)
            x = Screen.virtualX + Screen.width - width - 20
            y = 20
        }
    }
    Component.onCompleted: function(){
        //console.log("asdfasdfasdfasdf",Screen.desktopAvailableWidth)
    }
}
