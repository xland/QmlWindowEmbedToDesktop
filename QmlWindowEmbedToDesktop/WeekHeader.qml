import QtQuick 2.15

Repeater {
    model: ["日", "一", "二","三", "四", "五","六"]
    Rectangle {
        x:index*(body.width/7)
        height:50
        width:body.width/7
        color:"#00000000"
        anchors.top: body.top
        Text{
            color:"#ff4C4F54"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text:modelData
        }
    }
}