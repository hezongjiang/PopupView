//
//  PopupAlertView.swift
//  taijixinStudent
//
//  Created by he on 2017/11/16.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

private let margin: CGFloat = 10

class PopupAlertView: PopupView {

    /// 标题
    private let titleLabel = UILabel()
    
    /// 内容
    private let messageLabel = UILabel()
    
    /// 按钮模型
    private var items: [PopupItem]?
    
    /// 按钮集合视图
    private var buttonsView = UIView()
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - items: 按钮
    init(title: String?, message: String?, items: [PopupItem]) {
        super.init(frame: CGRect())
        
        popType = .alert
        
        if title != nil {
            
            titleLabel.text = title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textAlignment = .center
            popupView.addSubview(titleLabel)
        }
        
        if message != nil {
            
            messageLabel.text = message
            messageLabel.font = UIFont.systemFont(ofSize: 15)
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            popupView.addSubview(messageLabel)
        }
        
        self.items = items
        
        popupView.addSubview(buttonsView)
        
        for (i, item) in items.enumerated() {
            let itemBtn = UIButton()
            let titleColor = (item.type == .normal) ? UIColor.black : UIColor.red
            itemBtn.setTitleColor(titleColor, for: .normal)
            itemBtn.setTitleColor(UIColor.lightGray, for: .highlighted)
            itemBtn.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            itemBtn.layer.borderWidth = 0.5
            itemBtn.setTitle(item.title, for: .normal)
            itemBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            itemBtn.tag = i
            itemBtn.addTarget(self, action: #selector(itemClick(_:)), for: .touchUpInside)
            buttonsView.addSubview(itemBtn)
        }
    }
    
    @objc private func itemClick(_ btn: UIButton) {
        items?[btn.tag].click?()
        close()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if titleLabel.text != nil && messageLabel.text != nil { // 有标题、有内容
            
            titleLabel.frame = CGRect(x: margin, y: margin, width: popupView.bounds.width - 2 * margin, height: 32)
            let labelSize = messageLabel.sizeThatFits(CGSize(width: titleLabel.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            messageLabel.frame = CGRect(origin: CGPoint(x: margin, y: titleLabel.frame.maxY + margin), size: CGSize(width: titleLabel.bounds.width, height: labelSize.height))
            
        } else if titleLabel.text != nil && messageLabel.text == nil { // 有标题、无内容
            
            messageLabel.isHidden = true
            titleLabel.frame = CGRect(x: margin, y: margin, width: popupView.bounds.width - 2 * margin, height: 40)
            
        } else if titleLabel.text == nil && messageLabel.text != nil { // 无标题、有内容
            
            titleLabel.isHidden = true
            let messageWidth = popupView.bounds.width - 4 * margin
            let labelSize = messageLabel.sizeThatFits(CGSize(width: messageWidth, height: CGFloat.greatestFiniteMagnitude))
            messageLabel.frame = CGRect(x: margin * 2, y: margin * 2, width: messageWidth, height: labelSize.height)
            
        } else {
            titleLabel.isHidden = true
            messageLabel.isHidden = true
        }
        
        var buttonsViewY: CGFloat = 0
        
        if !messageLabel.isHidden {
            buttonsViewY = messageLabel.frame.maxY + margin * (titleLabel.isHidden ? 2 : 1.5)
        } else if !titleLabel.isHidden && messageLabel.isHidden {
            buttonsViewY = titleLabel.frame.maxY + margin
        }
        
        let buttons = buttonsView.subviews
        
        if buttons.count == 0 {
            popupView.frame.size.height = buttonsViewY
            popupView.center = center
            return
        }
        
        let buttonHeight: CGFloat = 40
        
        buttonsView.frame = CGRect(x: 0, y: buttonsViewY, width: popupView.bounds.width, height: buttonHeight)
        
        if buttons.count == 1 {
            buttons.first?.frame = CGRect(x: 0, y: 0, width: buttonsView.bounds.width, height: buttonHeight)
        } else if buttons.count == 2 {
            buttons.first?.frame = CGRect(x: 0, y: 0, width: buttonsView.bounds.width * 0.5, height: buttonHeight)
            buttons.last?.frame = CGRect(x: buttons.first!.frame.maxX, y: 0, width: buttons.first!.bounds.width, height: buttonHeight)
        } else {
            for (i, btn) in buttons.enumerated() {
                btn.frame = CGRect(x: 0, y: CGFloat(i) * buttonHeight, width: buttonsView.bounds.width, height: buttonHeight)
            }
            buttonsView.frame.size.height = CGFloat(buttons.count) * buttonHeight
        }
        
        popupView.frame.size.height = buttonsView.frame.maxY
        popupView.center = center
        print("\(#function): \(popupView.frame)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
