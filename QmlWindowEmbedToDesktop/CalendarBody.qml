import QtQuick
import "Calendar.js" as Calendar
Repeater {
    id:calendarBody
    model: []
    property int hoverIndex:-1
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
                if(hoverIndex != i){
                    item.color = "#88FFFFFF"
                    if(hoverIndex != -1){
                        calendarBody.itemAt(hoverIndex).children[0].color = "#00000000"
                    }                    
                    hoverIndex = i;
                    return;
                }
            }
        }
    }
    function mouseDown(x,y){
        if(hoverIndex < 0) return;
        let {year,month,date} = model[hoverIndex]
        conn.send({ msgType: 'EmbedCalendar',msgName: 'changeDate',data: {year,month,date}})
    }
    function getTextColor(data){
        if(data.isActive){
            return "#FFFFFFFF"
        }else if(data.type === "currt"){
            return "#FF1F2329"
        }else{
            return "#FF666666"
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
            color:modelData.isActive?"#FFF02C38":"#00000000"
            border {
                width: 1
                color: modelData.isToday?"#FFF02C38":"#00000000"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                property int year:modelData.year;
                property int month:modelData.month;
                property int date:modelData.date;
                onEntered: {
                    if(modelData.isActive) return;
                    parent.color = "#88FFFFFF";
                }
                onExited: {
                    if(modelData.isActive) return;
                    parent.color = "#00000000";
                }
                onPressed: {
                    conn.send({ msgType: 'EmbedCalendar',msgName: 'changeDate',data: {year,month,date}})
                }
            }
            Text{
                id:dayNumText
                color:getTextColor(modelData)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 6
                font.pixelSize: 20
                text:modelData.date
            }
            Text{
                id:dayText
                color:getTextColor(modelData)
                anchors.top: dayNumText.bottom
                anchors.topMargin: -3
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 12
                text:modelData.lunarInfo
            }
            Text{
                color:getTextColor(modelData)
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
                color:getTextColor(modelData)
                radius:6
                visible:modelData.hasSchdule
            }
        }
    }
}