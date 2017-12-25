//
//  CustomView.swift
//  PopupView
//
//  Created by he on 2017/12/25.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

class CustomView: UIView {

    class func show() -> CustomView {
        return Bundle.main.loadNibNamed("CustomView", owner: nil, options: nil)?.first as! CustomView
    }

}
