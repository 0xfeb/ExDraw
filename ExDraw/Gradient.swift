//
//  Gradient.swift
//  ExDraw
//
//  Created by 王渊鸥 on 2018/7/26.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public extension CGGradient {
    public static func colors(_ colorList: [UIColor]) -> CGGradient? {
        if colorList.count < 2 { return nil }
        
        let colors = colorList.map({ $0.cgColor })
        return CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: nil)
    }
}

public extension CGContext {
    public func fill(gradient:CGGradient, inRect rect:CGRect, direction: Direction?, inPath path: UIBezierPath? = nil) {
        self.saveGState()
        let path = path ?? UIBezierPath(rect: rect)
        path.addClip()
        if let direction = direction {
            self.drawLinearGradient(gradient,
                                       start: rect.point(of: direction).opsitePoint(baseOf: rect.center),
                                       end: rect.point(of: direction),
                                       options: .drawsAfterEndLocation)
        } else {
            self.drawRadialGradient(gradient,
                                       startCenter: rect.center,
                                       startRadius: 0,
                                       endCenter: rect.center,
                                       endRadius: rect.width/2.0,
                                       options: .drawsAfterEndLocation)
        }
        
        self.restoreGState()
    }
}

public extension UIImage {
    static func gradientImage(_ gradient:CGGradient, screen:CGSize, direction: Direction?, inPath path:UIBezierPath? = nil) -> UIImage {
        let image = UIGraphicsImageRenderer(size: screen)
            .image(actions: { (context) in
                context.cgContext.fill(gradient:gradient,
                                       inRect:CGRect(origin: CGPoint.zero, size: screen),
                                       direction:direction,
                                       inPath:path)
            })
        return image
    }
}
