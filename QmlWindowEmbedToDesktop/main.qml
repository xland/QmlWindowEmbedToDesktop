import QtQuick
import QtQuick.Window

Window {
    id:root
    flags: Qt.ToolTip | Qt.FramelessWindowHint
    color: "#00000000"
    visible: true
    width: 640
    height: 480
    title: "QtEmbededWindow"
    property point winPos: Qt.point(0, 0)
    Rectangle {
        id: bg
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        radius: [0, 6, 0, 0]
        color: "#ccbbbbbb"  
        TitleBar {
            id: titleBar            
            width: parent.width
        }      
    }
}
