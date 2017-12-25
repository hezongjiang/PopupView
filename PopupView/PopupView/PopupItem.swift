//
//  PopupItem.swift
//  taijixinStudent
//
//  Created by he on 2017/11/16.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

enum ItemType {
    case normal
    case destruct
}

class PopupItem {
    
    var title: String!
    
    var type: ItemType!
    
    var click: (() -> ())?
    
    init(title: String, type: ItemType, click: (() -> ())?) {
        self.title = title
        self.type = type
        self.click = click
    }
}

