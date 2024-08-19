import QtQuick
import QtQuick.Window


Window {
    id:root
    flags: Qt.ToolTip | Qt.FramelessWindowHint
    color: "#00000000"
    visible: true
    width: 580
    height: 580
    title: "QtEmbededWindow"
    property point winPos: Qt.point(0, 0)
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
        TitleBar {
            id: titleBar
        }
        CalendarHeader {
            id: calendarHeader
        }
        Rectangle {
            id:body
            anchors.top: calendarHeader.bottom
            anchors.left: bg.left
            anchors.right: bg.right
            anchors.topMargin:6
            anchors.leftMargin:10
            anchors.rightMargin:10
            WeekHeader {
                id: weekHeader
            }  
            CalendarBody {
                id: calendarBody
            }
        }
        SwitchBtn {
            id: switchBtn
        }
    }
}
