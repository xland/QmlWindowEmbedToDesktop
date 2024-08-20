import QtQuick
import QtQuick.Controls 

ScrollView{
    anchors.top: listHeader.bottom
    anchors.topMargin: 8
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    clip:true
    ListView {
        model: 18
        delegate: Rectangle {
            y:56 * index
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
} 