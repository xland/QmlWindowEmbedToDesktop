import QtQuick

Repeater {
    model: []
    Rectangle {
        x:index*(body.width/7)
        height:50
        width:body.width/7
        color:"#00000000"
        anchors.top: body.top
        Text{
            color:skin.text1
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text:modelData
        }
    }
}