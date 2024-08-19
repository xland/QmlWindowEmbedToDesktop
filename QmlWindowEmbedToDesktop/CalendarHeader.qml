import QtQuick

Rectangle {
    color: "#00000000"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: titleBar.bottom
    anchors.topMargin: 3
    width:270
    height:40
    component IconBtn: Rectangle {
        property string iconCode:"\uf053"
        color: "#00000000"
        anchors.top: parent.top
        anchors.topMargin:4
        width:32
        height:32
        radius:32
        signal clicked()
        border {
            width: 0.6
            color: "#ff797B7F"
        }
        Text{
            color:"#ff4C4F54"
            font.family: fontLoader.name
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: iconCode
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = "#4bffffff";
            }
            onExited: {
                parent.color = "#00000000";
            }
            onPressed: {
                parent.clicked();
            }
        }
    }
    IconBtn {
        id:goPreMonthBtn
        anchors.left: parent.left
        onClicked: {
            console.log("Clicked in Parent");
        }
    }
    Rectangle {
        anchors.left: goPreMonthBtn.right
        anchors.right: goNextMonthBtn.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "#00000000"
        Text{
            color:"#FF1F2329"
            font.pixelSize: 28
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "2024年8月"
        }
    }
    IconBtn {
        id:goNextMonthBtn
        anchors.right: parent.right
        iconCode:"\uf054"
        onClicked: {
            console.log("Clicked in Parent");
        }
    }    
}