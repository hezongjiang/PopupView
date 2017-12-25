//
//  PopupView.swift
//  taijixinStudent
//
//  Created by he on 2017/11/16.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

enum PopupType {
    case alert
    case sheet
}

class PopupView: UIView {

    /// 弹出类型，默认是从中间弹出
    var popType = PopupType.alert
    
    /// 弹出视图
    let popupView = UIView()
    
    /// 动画时间
    var animateDuration: TimeInterval = 0.25
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.frame = UIScreen.main.bounds
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        alpha = 0
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        
        popupView.backgroundColor = UIColor.white
        popupView.layer.cornerRadius = 5
        popupView.layer.borderWidth = 0.5
        popupView.clipsToBounds = true
        popupView.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
        addSubview(popupView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    @objc private func orientationDidChange() {
        frame = UIScreen.main.bounds

        let width = bounds.width
        let height = bounds.height
        
        switch popType {
            
        case .sheet:
            
            popupView.frame.origin = CGPoint(x: 0, y: height - popupView.bounds.height)
            popupView.frame.size.width = width
            if popupView.subviews.count == 1 {
                popupView.subviews[0].frame.size.width = width
            }
        case .alert:
            popupView.center = CGPoint(x: width * 0.5, y: height * 0.5)
            if popupView.bounds.width > width {
                popupView.frame.size.width = width - 2
            }
            if popupView.bounds.height > height {
                popupView.frame.size.height = height - 2
            }
        }
        print("\(#function): \(popupView.frame)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("\(self)销毁")
    }
    
    @objc func close() {
        
        switch popType {
        case .alert:
            alertHidenAnimation()
        case .sheet:
            sheetHidenAnimation()
        }
    }
    
    private func setupFrame() {
        
        let width = bounds.width
        let height = bounds.height
        
        switch popType {
            
        case .sheet:
            
            popupView.frame.origin = CGPoint(x: 0, y: height)
            popupView.frame.size.width = width
            if popupView.subviews.count == 1 {
                popupView.frame.size.height = popupView.subviews[0].bounds.height
            }
            
            if popupView.bounds.height < 10 { popupView.frame.size.height = 10 }
            
        case .alert:
            
            if popupView.subviews.count == 1 {
                var pop_width = popupView.subviews[0].bounds.width
                if pop_width >= width { pop_width = width - 2 }
                popupView.frame = CGRect(x: 0, y: 0, width: pop_width, height: popupView.subviews[0].bounds.height)
            }
            
            if popupView.bounds.width < 10 || popupView.bounds.height < 10 {
                let pop_width = (width * 0.6 < 260) ? 260 : width * 0.6
                popupView.frame = CGRect(x: 0, y: 0, width: pop_width, height: pop_width)
            }
            popupView.center = CGPoint(x: width * 0.5, y: height * 0.5)
        }
        print("\(#function): \(popupView.frame)")
    }
    
    func show() {
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        switch popType {
            
        case .sheet:
            
            popupView.layer.cornerRadius = 0
            sheetShowAnimation()
            
        case .alert:
            
            alertShowAnimation()
        }
    }
}

// MARK: - popView动画
private extension PopupView {
    
    /// sheet出现动画
    func sheetShowAnimation() {
        
        setupFrame()
        
        self.alpha = 1
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        UIView.animate(withDuration: animateDuration) {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.popupView.frame.origin.y = self.bounds.height - self.popupView.bounds.height
            print("\(#function): \(self.popupView.frame)")
        }
    }
    
    /// sheet隐藏动画
    func sheetHidenAnimation() {
        
        UIView.animate(withDuration: animateDuration, animations: {
            self.popupView.frame.origin.y = self.bounds.height
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    /// alert出现动画
    func alertShowAnimation() {
        
        setupFrame()
        
        popupView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2)
        
        UIView.animate(withDuration: animateDuration, animations: {
            self.alpha = 1
            self.popupView.layer.transform = CATransform3DIdentity
        }) { (_) in
            
        }
    }
    
    /// alert隐藏动画
    func alertHidenAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.toValue = 0.8
        anim.duration = animateDuration
        popupView.layer.add(anim, forKey: nil)
        
        UIView.animate(withDuration: animateDuration, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
