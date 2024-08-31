import QtQuick
import QtQuick.Controls

Rectangle {
    id:listBody
    property var listBodyData:[]
    property real totalHeight:0
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
                    item.children[0].children[3].visible = true
                }else{
                    item.children[0].color = "#00000000"
                    item.children[0].children[3].visible = false
                }
            }
        }else if(mouseInFlag){
            mouseInFlag = false
            for(let i=0;i<listRepeater.count;i++){
                let item = listRepeater.itemAt(i)
                item.children[0].color = "#00000000"
                item.children[0].children[3].visible = false
            }
        }
    }
    function setListData(data){
        listBodyData = data;
        totalHeight = data.length*56;
        scroller.visible = totalHeight > (860-580)
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
                radius:3
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
                Rectangle{
                    id:btnBox
                    z:88
                    visible:false
                    width:48
                    height:48
                    color:"#00000000"
                    anchors.right: parent.right
                    anchors.rightMargin: 6
                    Rectangle {
                        id:delBtn
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        width:28
                        height:24
                        color:"#00FFFFFF"
                        radius:3
                        ToolTip {
                            id:delToolTip
                            text: "删除日程"
                            visible: false
                            delay: 600
                            timeout: 6000
                            background: Rectangle {
                                color: "#FF1A1A1A"
                                radius: 4
                            }
                            contentItem: Text {
                                text: delToolTip.text
                                color: "#FFFFFFFF"
                            }
                        }
                        Text {
                            font.family: fontLoader.name
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color:"#FF333333"
                            text: "\ue712"
                        }
                    }
                    Rectangle {
                        id:editBtn
                        anchors.right: delBtn.left
                        anchors.verticalCenter: parent.verticalCenter
                        radius:3
                        width:28
                        height:24
                        color:"#00000000"
                        ToolTip {
                            id:editToolTip
                            text: "编辑日程"
                            visible: false
                            delay: 600
                            timeout: 6000
                            background: Rectangle {
                                color: "#FF1A1A1A"
                                radius: 4
                            }
                            contentItem: Text {
                                text: delToolTip.text
                                color: "#FFFFFFFF"
                            }
                        }
                        Text {
                            font.family: fontLoader.name
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color:"#FF333333"
                            text: "\ue707"
                        }
                    }
                }
                MouseArea {
                    z:2
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        parent.color = "#88ffffff";
                        btnBox.visible = true;
                    }
                    onPositionChanged:function(mouse){
                        if(mouse.x>btnBox.x+delBtn.x && 
                            mouse.x < btnBox.x+delBtn.x+delBtn.width && 
                            mouse.y > btnBox.y+delBtn.y && 
                            mouse.y < btnBox.y+delBtn.y+delBtn.height){
                            delBtn.color = "#BBFFFFFF"
                            delToolTip.visible = true
                        }else{
                            delBtn.color = "#00000000"
                            delToolTip.visible = false
                        }
                        if(mouse.x>btnBox.x+editBtn.x && 
                            mouse.x < btnBox.x+editBtn.x+editBtn.width && 
                            mouse.y > btnBox.y+editBtn.y && 
                            mouse.y < btnBox.y+editBtn.y+editBtn.height){
                            editBtn.color = "#BBFFFFFF"
                            editToolTip.visible = true
                        }else{
                            editBtn.color = "#00000000"
                            editToolTip.visible = false
                        }
                    }
                    onExited: {
                        parent.color = "#00000000";
                        btnBox.visible = false;
                    }
                }
            }
        }
    } 
    Rectangle {
        id:scroller
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        z:66
        radius:2
        width:6
        color:"#08000000"
        visible:false
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