import QtQuick
import QtQuick.Controls

Rectangle {
    id:listBody
    property var listBodyData:[]
    property real totalHeight:0
    property real position: 0
    property bool mouseInThumb:false
    property real mouseDownThumbY:-1000
    property int mouseInRownIndex:-1
    function wheelFunc(flag,x,y){
        if(isMouseIn(listBody,x,y)){
            listBody.position += flag ? -0.1 : 0.1
            listBody.position = Math.max(0, Math.min(1, listBody.position))
        }
    }
    function mouseDown(x,y){
        if(mouseInRownIndex != -1){
            let {scheduleNo,calendarNo,hoverDelBtn,hoverEditBtn,isAllowEdit} = listRepeater.itemAt(mouseInRownIndex);
            if(isAllowEdit){
                if(hoverDelBtn){
                    conn.send({ msgType: 'EmbedCalendar',msgName: 'deleteSchedule',
                                data: {scheduleNo,calendarNo}})
                }
                if(hoverEditBtn){
                    conn.send({ msgType: 'EmbedCalendar',msgName: 'updateSchedule',
                                data: {scheduleNo,calendarNo}})
                }            
            }
        }else if(isMouseIn(thumb,x,y)){
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
            for(let i=0;i<listRepeater.count;i++){
                let item = listRepeater.itemAt(i)
                let pos = item.mapToItem(null, 0, 0);
                if(y>pos.y && y<pos.y+item.height){
                    mouseInRownIndex = i;
                    item.children[0].color = "#88ffffff"
                    if(!item.isAllowEdit) continue;
                    let btnBox = item.children[0].children[3]
                    let editBtn = btnBox.children[1]
                    let delBtn = btnBox.children[0]
                    btnBox.visible = true
                    if(x>pos.x+btnBox.x+delBtn.x && 
                        x < pos.x+btnBox.x+delBtn.x+delBtn.width && 
                        y > pos.y+btnBox.y+delBtn.y && 
                        y < pos.y+btnBox.y+delBtn.y+delBtn.height){
                        delBtn.color = "#BBFFFFFF"
                        item.hoverDelBtn = true
                        //delToolTip.visible = true
                    }else{
                        delBtn.color = "#00000000"
                        item.hoverDelBtn = false
                        //delToolTip.visible = false
                    }
                    if(x>pos.x+btnBox.x+editBtn.x && 
                        x < pos.x+btnBox.x+editBtn.x+editBtn.width && 
                        y > pos.y+btnBox.y+editBtn.y && 
                        y < pos.y+btnBox.y+editBtn.y+editBtn.height){
                        editBtn.color = "#BBFFFFFF"
                        item.hoverEditBtn = true
                        //editBtn.visible = true
                    }else{
                        editBtn.color = "#00000000"
                        item.hoverEditBtn = false
                        //editBtn.visible = false
                    }
                }else{
                    item.children[0].color = "#00000000"
                    item.children[0].children[3].visible = false
                }
            }
        }else if(mouseInRownIndex > -1){
            mouseInRownIndex = -1
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
            property string scheduleNo:modelData.scheduleNo
            property string calendarNo:modelData.calendarNo
            property bool isAllowEdit:modelData.isAllowEdit
            property bool hoverDelBtn:false
            property bool hoverEditBtn:false
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
                    color:skin.text0
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
                    color:skin.text2
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
                                color: skin.toolTipBg
                                radius: 4
                            }
                            contentItem: Text {
                                text: delToolTip.text
                                color: skin.toolTipText
                            }
                        }
                        Text {
                            font.family: fontLoader.name
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color:skin.text1
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
                                color: skin.toolTipBg
                                radius: 4
                            }
                            contentItem: Text {
                                text: editToolTip.text
                                color: skin.toolTipText
                            }
                        }
                        Text {
                            font.family: fontLoader.name
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color:skin.text1
                            text: "\ue707"
                        }
                    }
                }
                MouseArea {
                    z:2
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        parent.color = "#33ffffff";
                        if(!modelData.isAllowEdit) return;
                        btnBox.visible = true;
                    }
                    onPressed: {
                        if(!modelData.isAllowEdit) return;
                        if(hoverDelBtn){
                            conn.send({ msgType: 'EmbedCalendar',msgName: 'deleteSchedule',
                            data: {scheduleNo,calendarNo}})
                        }
                        if(hoverEditBtn){
                            conn.send({ msgType: 'EmbedCalendar',msgName: 'updateSchedule',
                            data: {scheduleNo,calendarNo}})
                        }                        
                    }
                    onPositionChanged:function(mouse){
                        if(!modelData.isAllowEdit) return;
                        if(mouse.x>btnBox.x+delBtn.x && 
                            mouse.x < btnBox.x+delBtn.x+delBtn.width && 
                            mouse.y > btnBox.y+delBtn.y && 
                            mouse.y < btnBox.y+delBtn.y+delBtn.height){
                            delBtn.color = "#BBFFFFFF"
                            delToolTip.visible = true
                            hoverDelBtn = true
                        }else{
                            delBtn.color = "#00000000"
                            delToolTip.visible = false
                            hoverDelBtn = false
                        }
                        if(mouse.x>btnBox.x+editBtn.x && 
                            mouse.x < btnBox.x+editBtn.x+editBtn.width && 
                            mouse.y > btnBox.y+editBtn.y && 
                            mouse.y < btnBox.y+editBtn.y+editBtn.height){
                            editBtn.color = "#BBFFFFFF"
                            editToolTip.visible = true
                            hoverEditBtn = true
                        }else{
                            editBtn.color = "#00000000"
                            editToolTip.visible = false
                            hoverEditBtn = false
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