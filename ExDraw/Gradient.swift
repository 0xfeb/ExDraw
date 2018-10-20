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
    public static func dual(_ color0: UIColor, _ color1: UIColor) -> CGGradient? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [color0.cgColor, color1.cgColor]
        let locs:[CGFloat] = [0.0, 1.0]
        return CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locs)
    }
    
    public static func multi(colorList: [UIColor]) -> CGGradient? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = colorList.map({ $0.cgColor })
        let locs:[CGFloat] = Array(stride(from: CGFloat(0.0), to: CGFloat(1.0), by: CGFloat(1.0)/CGFloat(colorList.count)))
        return CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locs)
    }

    public func fill(inPath path: UIBezierPath, direction: ExDirection = .toBottom) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.saveGState()
        path.addClip()
        let frame = ex_rect(0, 0, 1, 1)
        context.drawLinearGradient(self, start: direction.point(of: frame), end: direction.point(of: frame), options: CGGradientDrawingOptions.drawsAfterEndLocation)
        context.restoreGState()
    }
    
    public func image(size: CGSize, direction: ExDirection? = .toRight) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        if let direction = direction {
            let startPoint = direction.opsite.point(of: rect)
            let endPoint = direction.point(of: rect)
            return UIGraphicsImageRenderer(bounds: rect).image(actions: { (context) in
                context.cgContext.drawLinearGradient(self, start: startPoint, end: endPoint, options: [])
            })
        } else {
            let center = rect.center
            let length = rect.outterCycle.width
            return UIGraphicsImageRenderer(bounds: rect).image(actions: { (context) in
                context.cgContext.drawRadialGradient(self, startCenter: center, startRadius: 0, endCenter: center, endRadius: length, options: [])
            })
        }
    }
}
