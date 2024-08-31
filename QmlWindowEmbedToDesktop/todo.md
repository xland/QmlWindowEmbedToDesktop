1. tooltip
1. 鼠标只有在桌面上的时候，才转发事件
1. 嵌入，列表滚动条拖动滚动，可以超出范围
1. 上一个月，下一个月
1. 多皮肤
1. 鼠标移入与移出圆形区域
1. 钉住按钮，钉住了之后有个背景色
1. 设置按钮的菜单

--------------------

1. 一个小时取一次数据
1. 初始化窗口的位置
1. 适应不同缩放比例的屏幕
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