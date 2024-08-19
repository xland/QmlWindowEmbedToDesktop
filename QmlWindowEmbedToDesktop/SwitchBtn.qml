import QtQuick

Rectangle {
    anchors.right:bg.right
    anchors.rightMargin:30
    height:48
    width:120
    color:"#00000000"
    anchors.bottom: bg.bottom
    anchors.bottomMargin:16
    Text {
        id:showJobText
        color:"#ff007AFF"
        font.pixelSize: 20
        anchors.left:parent.left
        anchors.leftMargin:10
        anchors.verticalCenter: parent.verticalCenter
        text: "显示日程"
    }
    Text {
        font.family: fontLoader.name
        color:"#ff007AFF"
        font.pixelSize: 20
        anchors.left:showJobText.right
        anchors.leftMargin:2
        anchors.verticalCenter: parent.verticalCenter
        text: "\uf078"
    }
}