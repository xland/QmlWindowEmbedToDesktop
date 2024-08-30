import QtQuick
import QtQuick.Controls

Rectangle {
    id:listBody
    property var listBodyData:[]
    property real totalHeight:18*56
    property real position: 0
    property bool mouseInFlag:false
    property bool mouseInThumb:false
    property real mouseDownThumbY:-1000
    function wheelFunc(flag,x,y){
        if(isMouseIn(listBody,x,y)){
            listBody.position += flag ? -0.1 : 0.1
            listBody.position = Math.max(0, Math.min(1, listBody.position))
        }
    }
    function mouseDown(x,y){
        if(isMouseIn(thumb,x,y)){
            mouseDownThumbY = y;
        }
    }
    function mouseUp(x,y){
        mouseDownThumbY = -1000
    }
    function mouseMove(x,y){
        if(mouseDownThumbY != -1000){
            thumb.y += (y-mouseDownThumbY);
            listBody.position = thumb.y / (thumb.parent.height - thumb.height)
            listBody.position = Math.max(0, Math.min(1, listBody.position))
            mouseDownThumbY = y;
            return;
        }
        if(isMouseIn(thumb,x,y)){
            thumb.color = "#40000000";
            mouseInThumb = true;
            return;
        }
        if(mouseInThumb){
            thumb.color = "#20000000";
            mouseInThumb = false;            
        }
        if(isMouseIn(listBody,x,y)){
            mouseInFlag = true
            for(let i=0;i<listRepeater.count;i++){
                let item = listRepeater.itemAt(i)
                let pos = item.mapToItem(null, 0, 0);
                if(y>pos.y && y<pos.y+item.height){
                    item.children[0].color = "#88ffffff"
                }else{
                    item.children[0].color = "#00000000"
                }
            }
        }else if(mouseInFlag){
            mouseInFlag = false
            for(let i=0;i<listRepeater.count;i++){
                let item = listRepeater.itemAt(i)
                item.children[0].color = "#00000000"
            }
        }
    }
    anchors.top: listHeader.bottom
    anchors.topMargin: 8
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    color:"#00000000"
    clip:true
    Repeater {
        id:listRepeater
        model: listBodyData
        delegate: Rectangle {
            y:-listBody.position * (totalHeight - listBody.height) + 56 * index
            width: parent.width
            height:56
            color:"#00000000"
            Rectangle {
                y:8
                width: parent.width
                height:48
                color:"#00000000"
                Rectangle {
                    id:leftBorder
                    topLeftRadius: 18
                    bottomLeftRadius: 18
                    width:3
                    color:"#FF4A53E7"
                    height:48
                }
                Text {
                    id:title
                    y:2
                    font.pixelSize: 16
                    anchors.left: leftBorder.right
                    anchors.right: parent.right
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    color:"#FF1F2329"
                    elide: Text.ElideRight
                    text: modelData.title
                }
                Text {
                    anchors.top: title.bottom
                    anchors.left: leftBorder.right
                    anchors.right: parent.right
                    anchors.topMargin: 4
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    font.pixelSize: 14
                    color:"#FF666666"
                    elide: Text.ElideRight
                    text: modelData.desc
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        parent.color = "#88ffffff";
                    }
                    onExited: {
                        parent.color = "#00000000";
                    }
                }
            }
        }
    } 
    Rectangle {        
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        z:6
        radius:2
        width:6
        color:"#08000000"
        Rectangle {
            id:thumb
            anchors.right: parent.right
            y: listBody.position * (parent.height - height)
            radius:2
            width:6
            height:Math.max(parent.height / totalHeight * parent.height, 20)
            color:"#20000000"
            MouseArea {
                property real mouseY: 0
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.color = "#40000000";
                }
                onExited: {
                    parent.color = "#20000000";
                }
                drag.target: parent
                drag.axis: Drag.YAxis
                onReleased: {
                    listBody.position = thumb.y / (thumb.parent.height - thumb.height)
                    listBody.position = Math.max(0, Math.min(1, listBody.position))
                    mouseDownThumb = false;
                }
                onPositionChanged: {
                    listBody.position = thumb.y / (thumb.parent.height - thumb.height)
                    listBody.position = Math.max(0, Math.min(1, listBody.position))
                }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton
        onWheel: {
            let flag = (wheel.angleDelta.y > 0)
            listBody.position += flag ? -0.1 : 0.1
            listBody.position = Math.max(0, Math.min(1, listBody.position))
        }
    }
} 