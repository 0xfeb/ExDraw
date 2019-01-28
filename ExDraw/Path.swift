//
//  Path.swift
//  ExDraw
//
//  Created by 王渊鸥 on 2018/10/19.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import CoreGraphics

fileprivate let bigApart = "$"
fileprivate let smallApart = "&"

public extension CGPath {
    public static func from(text:String) -> CGPath {
        let actions = text.components(separatedBy: bigApart)
        let path = CGMutablePath()
        actions.forEach { (action) in
            let parts = action.components(separatedBy: smallApart)
            guard let _type = Int32(parts[0]) else { return }
            guard let type = CGPathElementType(rawValue: _type) else { return }
            switch type {
            case .closeSubpath:
                path.closeSubpath()
            case .moveToPoint:
                if parts.count < 2 { return }
                let _point = parts[1]
                guard let point = CGPoint(text:_point) else { return }
                path.move(to: point)
            case .addLineToPoint:
                if parts.count < 2 { return }
                let _point = parts[1]
                guard let point = CGPoint(text:_point) else { return }
                path.addLine(to: point)
            case .addQuadCurveToPoint:
                if parts.count < 3 { return }
                let _control = parts[1], _point = parts[2]
                guard let point = CGPoint(text:_point),
                    let control = CGPoint(text:_control) else { return }
                path.addQuadCurve(to: point, control: control)
            case .addCurveToPoint:
                if parts.count < 4 { return }
                let _control1 = parts[1], _control2 = parts[2], _point = parts[3]
                guard let control1 = CGPoint(text: _control1),
                    let control2 = CGPoint(text: _control2),
                    let point = CGPoint(text: _point) else { return }
                path.addCurve(to: point, control1: control1, control2: control2)
            }
        }
        
        return path
    }
    
    @available(iOS 11.0, *)
    public var text:String {
        var result:String = ""
        
        self.applyWithBlock { (pt) in
            switch pt.pointee.type {
            case .addCurveToPoint:
                let control1 = pt.pointee.points[0]
                let control2 = pt.pointee.points[1]
                let point = pt.pointee.points[2]
                let action = "\(pt.pointee.type.rawValue)\(smallApart)\(control1.text)\(smallApart)\(control2.text)\(smallApart)\(point.text)"
                if result.hasSuffix(bigApart) {
                    result += action
                } else {
                    result += (bigApart + action)
                }
            case .moveToPoint, .addLineToPoint:
                let point = pt.pointee.points[0]
                let action = "\(pt.pointee.type.rawValue)\(smallApart)\(point.text)"
                if result.hasSuffix(bigApart) {
                    result += action
                } else {
                    result += (bigApart + action)
                }
            case .addQuadCurveToPoint:
                let control = pt.pointee.points[0]
                let point = pt.pointee.points[1]
                let action = "\(pt.pointee.type.rawValue)\(smallApart)\(control.text)\(smallApart)\(point.text)"
                if result.hasSuffix(bigApart) {
                    result += action
                } else {
                    result += (bigApart + action)
                }
            case .closeSubpath:
                let action = "\(pt.pointee.type.rawValue)"
                if result.hasSuffix(bigApart) {
                    result += action
                } else {
                    result += (bigApart + action)
                }
            }
        }
        
        return result
    }
}

public extension UIImage {
    static func pathImage(screen:CGSize, path:UIBezierPath, stroke:(UIColor, CGFloat)?, fill:UIColor?) -> UIImage {
        return UIGraphicsImageRenderer(size: screen)
            .image(actions: { (content) in
                content.cgContext.addPath(path.cgPath)
                
                if let fill = fill {
                    content.cgContext.setFillColor(fill.cgColor)
                    content.cgContext.fillPath()
                }
                
                if let stroke = stroke {
                    content.cgContext.setStrokeColor(stroke.0.cgColor)
                    content.cgContext.setLineWidth(stroke.1)
                    content.cgContext.strokePath()
                }
            })
    }
}
