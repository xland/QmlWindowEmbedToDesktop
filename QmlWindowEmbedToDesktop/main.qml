import QtQuick
import QtQuick.Window

Window {
    id:root
    flags: Qt.FramelessWindowHint
    color: "#00000000"
    visible: true
    width: 580
    height: 580  //580,860
    title: "QtEmbededWindow"
    property point winPos: Qt.point(0, 0)
    signal mouseMove(int x,int y)
    function isMouseIn(ele,x,y){
        var pos = ele.mapToGlobal(0, 0);
        console.log("222222222222222222222222",pos.x,pos.y,pos.x+ele.width,pos.y+ele.height)
        return (x>pos.x && x < pos.x+ele.width && y>pos.y && y<pos.y+ele.height)
    }
    function wheelFunc(flag){
        listBody.wheelFunc(flag);
    }
    function moveFunc(x,y){
        mouseMove(Qt.application.mouseX,Qt.application.mouseX)
    }
    FontLoader {
        id: fontLoader
        source: "fa-solid-900.ttf"
    }
    Rectangle {
        id: bg
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        radius: 4
        color: "#99FFFFFF"  
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
}
