import QtQuick

Rectangle {
    id:toolTip
    width: 200
    height: 100
    color: "red"
    Text {
        anchors.centerIn: parent
        text: "Hello, World!"
    }
}
