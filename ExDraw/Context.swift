//
//  Context.swift
//  ExDraw
//
//  Created by 王渊鸥 on 2018/7/26.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGContext {
    static var current: CGContext? {
        return UIGraphicsGetCurrentContext()
    }
    
    func flipV(height: CGFloat) {
        self.textMatrix = CGAffineTransform.identity
        self.translateBy(x: 0, y: height)
        self.scaleBy(x: 1.0, y: -1.0)
    }
}
