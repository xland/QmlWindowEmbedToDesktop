import QtQuick
import QtQuick.Controls

Rectangle {
    anchors.top: listHeader.bottom
    anchors.topMargin: 8
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    clip:true
    property int yScroll:0
    Repeater {
        id:listRepeater
        model: 18
        delegate: Rectangle {
            y:56 * index + parent.yScroll
            width: parent.width
            height:56
            color:"#00000000"
            Rectangle {
                y:8
                topLeftRadius: 6
                bottomLeftRadius: 6
                width:3
                color:"#FF4A53E7"
                height:48
                Text {
                    text: "这是第 " + (index + 1)
                }
            }
        }
    } 
    Rectangle {        
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        radius:2
        width:6
        color:"#08000000"
        Rectangle {
            id:thumb
            anchors.right: parent.right
            y:0
            radius:2
            width:6
            height:(parent.height/(18*56))*parent.height
            color:"#20000000"
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
        }
        onExited: {
        }
        onWheel: {
            let totalHeight = 18*56
            let span = totalHeight - parent.height
            let percent = yScroll / span;
            let span1 = parent.height - thumb.height
            let distance = span1*percent;
            console.log(distance)
            if (wheel.angleDelta.y > 0) {
                parent.yScroll += 12  //向上滚动
                thumb.y+=distance
            } else {
                parent.yScroll -= 12  //向下滚动
                thumb.y-=distance
            }
        }
    }
} 