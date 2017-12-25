//
//  ViewController.swift
//  PopupView
//
//  Created by he on 2017/12/25.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func alertStyle(_ sender: UIButton) {
        let item1 = PopupItem(title: "确定", type: .destruct) {
            print("点击了‘确定’按钮")
        }
        let item2 = PopupItem(title: "取消", type: .normal) {
            print("点击了‘取消’按钮")
        }
        let popView = PopupAlertView(title: "标题", message: "内容信息，此处可填写很多很多很多的内", items: [item1, item2])
        popView.show()
    }
    
    @IBAction func actionSheetStyle(_ sender: UIButton) {
        let item1 = PopupItem(title: "第一个按钮", type: .destruct) {
            print("点击了‘第一个按钮’按钮")
        }
        let item2 = PopupItem(title: "第二个按钮", type: .normal) {
            print("点击了‘第二个’按钮")
        }
        let sheetView = PopupSheetView(message: "message", items: [item1, item2])
        sheetView.show()
    }
    
    @IBAction func customStyle(_ sender: UIButton) {
        let popupView = PopupView()
        popupView.popupView.addSubview(CustomView.show())
        popupView.popType = .sheet
        popupView.show()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    }
}

