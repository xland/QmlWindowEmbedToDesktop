import QtQuick

Rectangle {
    anchors.right:bg.right
    height:48
    width:120
    color:"#00000000"
    anchors.bottom: bg.bottom
    Text {
        color:"#ff007AFF"
        font.pixelSize: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: "显示日程"
    }
}