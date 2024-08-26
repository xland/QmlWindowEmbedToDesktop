import QtQuick 2.15
import "Calendar.js" as Calendar
Repeater {
    model: []
    function roteMonth(val){
        model = Calendar.getOneMonthDate(val);
        calendarHeader.setYearMonth(Calendar.tarDate)
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
                color: "#ffF02C38"
            }
            Text{
                id:dayNumText
                color:modelData.isCurMonth? "#FF1F2329":"#ff666666"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 8
                font.pixelSize: 20
                text:modelData.day
            }
            Text{
                id:dayText
                color:"#ff4C4F54"
                anchors.top: dayNumText.bottom
                anchors.topMargin: -5
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 12
                text:"廿八"
            }
            Text{
                color:"#ffff0000"
                font.pixelSize: 10
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 8
                anchors.rightMargin: 7
                text:"休"
            }
            Rectangle {
                height:6
                width:6
                anchors.top: dayText.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color:"#88FF00FF"
                radius:6
            }
        }
    }
}