# PopupView
Elegant pop-view in Swift

![image](https://github.com/Hearsayer/PopupView/blob/master/ezgif.com-video-to-gif.gif)

## How to use

1、PopupAlertView
```swift
let item1 = PopupItem(title: "确定", type: .destruct) {
    print("点击了‘确定’按钮")
}
let item2 = PopupItem(title: "取消", type: .normal) {
    print("点击了‘取消’按钮")
}
let popView = PopupAlertView(title: "标题", message: "内容信息，此处可填写很多很多很多的内", items: [item1, item2])
popView.show()
```

2、PopupSheetView
```swift
let item1 = PopupItem(title: "第一个按钮", type: .destruct) {
    print("点击了‘第一个按钮’按钮")
 }
let item2 = PopupItem(title: "第二个按钮", type: .normal) {
    print("点击了‘第二个’按钮")
}
let sheetView = PopupSheetView(message: "message", items: [item1, item2])
sheetView.show()
```

3、PopupView
```swift
let popupView = PopupView()
popupView.popupView.addSubview(CustomView.show())
popupView.popType = .sheet
popupView.show()
```
