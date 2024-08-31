1. 展开任务列表按钮的鼠标移入样式
1. tooltip
1. 列表项的右侧需要两个按钮
1. 列表高度与窗口高度自适应
1. 鼠标只有在桌面上的时候，才转发事件

--------------------

1. 一个小时取一次数据
1. 初始化窗口的位置
1. 调整窗口透明度




```
visible: mouseArea.containsMouse
mouseArea.contains(mouse.x, mouse.y) ? mouseArea.entered.emit() : mouseArea.exited.emit();
```
```
    Dialog {
        id: dialog
        visible: false
        width: 300
        height: 200
        modal: true
        title: "My Dialog"
        Column {
            anchors.fill: parent
            spacing: 10
            Text {
                id:dialogText
                text: "This is a dialog."
                width: parent.width
                wrapMode: Text.Wrap
            }
            Button {
                text: "Close"
                width: parent.width
                onClicked: {
                    dialog.visible = false;
                }
            }
        }
    }
```