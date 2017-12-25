//
//  PopupSheetView.swift
//  taijixinStudent
//
//  Created by he on 2017/11/16.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

private let margin: CGFloat = 10

class PopupSheetView: PopupView {

    
    /// 提示文本
    let messageLabel = UILabel()
    
    /// 提示文本的View
    let messageView = UIView()
    
    /// 取消按钮
    let cancelButton = UIButton()
    
    /// 按钮视图
    let buttonsView = UIView()
    
    /// 按钮行高
    private let buttonHeight: CGFloat = 55
    
    /// 按钮模型
    private var items: [PopupItem]?
    
    init(message: String?, items: [PopupItem], showCancel: Bool = true) {
        super.init(frame: CGRect())
        
        popType = .sheet
        
        popupView.layer.cornerRadius = 0
        
        popupView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        var extentHeight = 0
        
        self.items = items
        
        if message != nil {
            messageLabel.textColor = UIColor.darkGray
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 14)
            messageLabel.text = message
            popupView.addSubview(messageView)
            messageView.addSubview(messageLabel)
            messageView.backgroundColor = UIColor.white
            extentHeight += 1
        }
        
        if showCancel {
            cancelButton.setTitle("取消", for: .normal)
            cancelButton.setTitleColor(UIColor.black, for: .normal)
            popupView.addSubview(cancelButton)
            cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            cancelButton.backgroundColor = UIColor.white
            cancelButton.addTarget(self, action: #selector(cancleClick), for: .touchUpInside)
            extentHeight += 1
        }
        
        buttonsView.backgroundColor = UIColor.white
        popupView.addSubview(buttonsView)
        
        for (i, item) in items.enumerated() {
            let itemBtn = UIButton()
            itemBtn.setTitle(item.title, for: .normal)
            let titleColor = (item.type == .normal) ? UIColor.black : UIColor.red
            itemBtn.setTitleColor(titleColor, for: .normal)
            itemBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            itemBtn.setTitleColor(UIColor.lightGray, for: .highlighted)
            itemBtn.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
            itemBtn.layer.borderWidth = 0.5
            itemBtn.tag = i
            itemBtn.addTarget(self, action: #selector(itemClick(_:)), for: .touchUpInside)
            buttonsView.addSubview(itemBtn)
        }
        
        popupView.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: buttonHeight * CGFloat(items.count + extentHeight) + margin)
    }
    
    @objc private func itemClick(_ btn: UIButton) {
        items?[btn.tag].click?()
        close()
    }
    
    @objc private func cancleClick() {
        close()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonH: CGFloat = 50
        
        if messageLabel.text != nil {
            messageView.frame = CGRect(x: 0, y: 0, width: popupView.bounds.width, height: buttonH)
            messageLabel.frame = CGRect(x: margin, y: 0, width: messageView.bounds.width - 2 * margin, height: messageView.bounds.height)
        }
        
        buttonsView.frame = CGRect(x: 0, y: messageLabel.frame.maxY, width: popupView.bounds.width, height: buttonH * CGFloat(buttonsView.subviews.count))
        
        for (i, button) in buttonsView.subviews.enumerated() {
            button.frame = CGRect(x: 0, y: CGFloat(i) * buttonH, width: buttonsView.bounds.width, height: buttonH)
        }
        
        cancelButton.frame = CGRect(x: 0, y: buttonsView.frame.maxY + 5, width: popupView.bounds.width, height: buttonH)
        
        popupView.frame = CGRect(x: 0, y: bounds.height - cancelButton.frame.maxY, width: bounds.width, height: cancelButton.frame.maxY)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
