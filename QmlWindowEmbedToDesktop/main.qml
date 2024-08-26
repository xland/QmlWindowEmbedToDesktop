import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id:root
    flags: Qt.FramelessWindowHint | Qt.ToolTip | Qt.WindowStaysOnTopHint | Qt.Popup
    color: "#00000000"
    visible: true
    width: 580
    height: 580  //580,860
    title: "QtEmbededWindow"
    function isMouseIn(ele,x,y){
        //let flag = (x>ele.x && x < ele.x+ele.width && y>ele.y && y<ele.y+ele.height)
        //return flag;
        var pos = ele.mapToItem(null, 0, 0);
        let flag = (x>pos.x && x < pos.x+ele.width && y>pos.y && y<pos.y+ele.height)
        return flag;
    }
    function wheelFunc(flag,x,y){
        listBody.wheelFunc(flag,x,y);
    }
    function moveFunc(x,y){
        titleBar.mouseMove(x,y)
        calendarHeader.mouseMove(x,y)
        switchBtn.mouseMove(x,y)
        listBody.mouseMove(x,y)
    }
    function downFunc(x,y){
        listBody.mouseDown(x,y)
    }
    function upFunc(x,y){
        listBody.mouseUp(x,y)
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
}
