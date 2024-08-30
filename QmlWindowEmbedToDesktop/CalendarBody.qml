import QtQuick
import "Calendar.js" as Calendar
Repeater {
    id:calendarBody
    model: []
    property int hoverIndex:-1
    function roteMonth(val){
        //model = Calendar.getOneMonthDate(val);
    }
    function mouseMove(x,y){
        if(x < 16 || x>root.width-16 || y < 146 || y> 490){            
            if(hoverIndex != -1){
                calendarBody.itemAt(hoverIndex).children[0].color = "#00000000"
                hoverIndex = -1
            }
        }
        for(let i=0;i<42;i++){
            let item = calendarBody.itemAt(i).children[0];
            if(isMouseIn(item,x,y)){
                console.log(hoverIndex,i)
                if(hoverIndex != i){
                    item.color = "#88985321"
                    if(hoverIndex != -1){
                        calendarBody.itemAt(hoverIndex).children[0].color = "#00000000"
                    }                    
                    hoverIndex = i;
                    return;
                }
            }
        }
    }
    Rectangle {
        x:(index%7)*(body.width/7)+11
        height:57
        width:body.width/7-22
        color:"#00000000"
        anchors.top: body.top
        anchors.topMargin: 52+57 * parseInt(index/7)
        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: 2
            height:55
            width:55
            radius:width
            color:"#00000000"
            border {
                width: 1
                color: modelData.isToday?"#FFF02C38":"#00000000"
            }
            Text{
                id:dayNumText
                color:modelData.type === 'currt'? "#FF1F2329":"#FF666666"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 8
                font.pixelSize: 20
                text:modelData.date
            }
            Text{
                id:dayText
                color:"#FF4C4F54"
                anchors.top: dayNumText.bottom
                anchors.topMargin: -5
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 12
                text:modelData.lunarInfo
            }
            Text{
                color:"#FFFF0000"
                font.pixelSize: 10
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 8
                anchors.rightMargin: 7
                text:modelData.docStatus
            }
            Rectangle {
                height:6
                width:6
                anchors.top: dayText.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color:"#88FF00FF"
                radius:6
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.color = "#88985321";
                }
                onExited: {
                    parent.color = "#00000000";
                }
            }
        }
    }
}