import QtQuick
import "Calendar.js" as Calendar
Repeater {
    model: []
    Rectangle {
        x:(index%7)*(body.width/7)+18
        height:57
        width:body.width/7-36
        color:"#00000000"
        anchors.top: body.top
        anchors.topMargin: 62+57 * parseInt(index/7)
        Text{
            id:dayNumText
            color:modelData.isCurMonth? "#FF1F2329":"#ff666666"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20
            text:modelData.day
        }
        Text{
            color:"#ff000000"
            anchors.top: dayNumText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
            text:"廿八"
        }
        Text{
            color:"#ffff0000"
            font.pixelSize: 10
            anchors.top: parent.top
            anchors.right: parent.right
            text:"休"
        }
    }
    Component.onCompleted: {
        let arr = Calendar.getOneMonthDate(new Date());
        model.push(...arr);
    }
}