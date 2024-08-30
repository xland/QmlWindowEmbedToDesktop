1. 调整窗口透明度
1. 日期鼠标移入样式
1. 展开任务列表按钮的鼠标移入样式
1. tooltip
1. 一个小时取一次数据
1. 列表高度与窗口高度自适应
1. 鼠标只有在桌面上的时候，才转发事件


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