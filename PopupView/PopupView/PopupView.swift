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

    /// 弹出类型，默认是中间弹出
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc private func orientationDidChange() {
        frame = UIScreen.main.bounds
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
    
    func show() {
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        let width = bounds.width
        let height = bounds.height
        
        switch popType {
            
        case .sheet:
            
            popupView.frame = CGRect(x: 0, y: height, width: width, height: 100)
            if popupView.subviews.count == 1 {
                popupView.frame.size.height = popupView.subviews[0].bounds.height
            }
            
            if popupView.bounds.height < 10 {
                popupView.frame.size.height = 10
            }
            popupView.layer.cornerRadius = 0
            sheetShowAnimation()
            
        case .alert:
            
            if popupView.subviews.count == 1 {
                var pop_width = popupView.subviews[0].bounds.width
                if pop_width >= width { pop_width = width - 2 }
                popupView.frame = CGRect(x: 0, y: 0, width: pop_width, height: popupView.subviews[0].bounds.height)
            }
            
            if popupView.bounds.width < 1 || popupView.bounds.height < 1 {
                let pop_width = (width * 0.6 < 260) ? 260 : width * 0.6
                popupView.frame = CGRect(x: 0, y: 0, width: pop_width, height: pop_width)
            }
            popupView.center = CGPoint(x: width * 0.5, y: height * 0.5)
            alertShowAnimation()
        }
    }
    
    private func sheetShowAnimation() {
        
        self.alpha = 1
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        UIView.animate(withDuration: animateDuration) {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.popupView.frame.origin.y = self.bounds.height - self.popupView.bounds.height
        }
    }
    
    private func sheetHidenAnimation() {
        
        UIView.animate(withDuration: animateDuration, animations: {
            self.popupView.frame.origin.y = self.bounds.height
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    private func alertShowAnimation() {
        
        popupView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2)
        
        UIView.animate(withDuration: animateDuration, animations: {
            self.alpha = 1
            self.popupView.layer.transform = CATransform3DIdentity
        }) { (_) in
            
        }
    }
    
    private func alertHidenAnimation() {
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
