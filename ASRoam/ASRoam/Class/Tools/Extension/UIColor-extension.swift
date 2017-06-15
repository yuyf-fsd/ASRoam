//
//  UIColor-extension.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/5.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
}
