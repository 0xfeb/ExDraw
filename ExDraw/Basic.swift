//
//  Builder.swift
//  ExRect
//
//  Created by 王渊鸥 on 2018/7/18.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import CoreGraphics

public func size(_ width:CGFloat, _ height:CGFloat) -> CGSize {
    return CGSize(width: width, height: height)
}

public func size(_ width:Double, _ height:Double) -> CGSize {
    return CGSize(width: width, height: height)
}

public func size(_ width:Int, _ height:Int) -> CGSize {
    return CGSize(width: width, height: height)
}

public func point(_ x:CGFloat, _ y:CGFloat) -> CGPoint {
    return CGPoint(x: x, y: y)
}

public func point(_ x:Double, _ y:Double) -> CGPoint {
    return CGPoint(x: x, y: y)
}

public func point(_ x:Int, _ y:Int) -> CGPoint {
    return CGPoint(x: x, y: y)
}

public func rect(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat, _ height:CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

public func rect(_ x:Double, _ y:Double, _ width:Double, _ height:Double) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

public func rect(_ x:Int, _ y:Int, _ width:Int, _ height:Int) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

// ----- Center of two points -----
public func centerOfLine(point1: CGPoint, point2: CGPoint) -> CGPoint {
    let xValue = (point1.x + point2.x)/2
    let yValue = (point1.y + point2.y)/2
    return CGPoint(x: xValue, y: yValue)
}

public func lengthOfLine(point1: CGPoint, point2: CGPoint) -> CGFloat {
    let xDistance = point1.x - point2.x
    let yDistance = point1.y - point2.y
    return sqrt(xDistance*xDistance + yDistance*yDistance)
}

public func angleOfLine(point1: CGPoint, point2: CGPoint) -> CGFloat {
    return atan2(point2.y - point1.y, point2.x - point1.x)
}

public func degreeOfRadian(_ radian:CGFloat) -> CGFloat {
    return radian * 180 / CGFloat.pi
}

public func radianOfDegree(_ angle:CGFloat) -> CGFloat {
    return angle * CGFloat.pi / 180
}

public extension CGRect {
    public init(center point: CGPoint, size: CGSize) {
        let origin = CGPoint(x: point.x - size.width/2, y: point.y - size.height/2)
        self.init(origin: origin, size: size)
    }

    public init(leftTop point: CGPoint, size: CGSize) {
        self.init(origin: point, size: size)
    }

    public init(rightTop point: CGPoint, size: CGSize) {
        let origin = CGPoint(x: point.x - size.width, y: point.y)
        self.init(origin: origin, size: size)
    }

    public init(leftBottom point: CGPoint, size: CGSize) {
        let origin = CGPoint(x: point.x, y: point.y - size.height)
        self.init(origin: origin, size: size)
    }

    public init(rightBottom point: CGPoint, size: CGSize) {
        let origin = CGPoint(x: point.x - size.width, y: point.y - size.height)
        self.init(origin: origin, size: size)
    }

    //Make a rect from two points
    public init(point1: CGPoint, point2: CGPoint) {
        let origin = CGPoint(x: min(point1.x, point2.x), y: min(point1.y, point2.y))
        let size = CGSize(width: abs(point1.x-point2.x), height: abs(point1.y-point2.y))
        self.init(origin: origin, size: size)
    }
}

public extension CGSize {
    static func + (_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width+rhs.width, height: lhs.height+rhs.height)
    }
    
    static func + (_ lhs: CGSize, _ rhs: CGPoint) -> CGSize {
        return CGSize(width: lhs.width+rhs.x, height: lhs.height+rhs.y)
    }
    
    static func + (_ lhs: CGSize, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return CGSize(width: lhs.width+rhs.0, height: lhs.height+rhs.1)
    }
    
    static func - (_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width-rhs.width, height: lhs.height-rhs.height)
    }
    
    static func - (_ lhs: CGSize, _ rhs: CGPoint) -> CGSize {
        return CGSize(width: lhs.width-rhs.x, height: lhs.height-rhs.y)
    }
    
    static func - (_ lhs: CGSize, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return CGSize(width: lhs.width-rhs.0, height: lhs.height-rhs.1)
    }
    
    static func * (_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width*rhs.width, height: lhs.height*rhs.height)
    }
    
    static func * (_ lhs: CGSize, _ rhs: CGPoint) -> CGSize {
        return CGSize(width: lhs.width*rhs.x, height: lhs.height*rhs.y)
    }
    
    static func * (_ lhs: CGSize, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return CGSize(width: lhs.width*rhs.0, height: lhs.height*rhs.1)
    }
    
    static func / (_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width/rhs.width, height: lhs.height/rhs.height)
    }
    
    static func / (_ lhs: CGSize, _ rhs: CGPoint) -> CGSize {
        return CGSize(width: lhs.width/rhs.x, height: lhs.height/rhs.y)
    }
    
    static func / (_ lhs: CGSize, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return CGSize(width: lhs.width/rhs.0, height: lhs.height/rhs.1)
    }
}

public extension CGPoint {
    static func + (_ lhs: CGPoint, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.x+rhs.width, height: lhs.y+rhs.height)
    }
    
    static func + (_ lhs: CGPoint, _ rhs: CGPoint) -> CGSize {
        return CGSize(width: lhs.x+rhs.x, height: lhs.y+rhs.y)
    }
    
    static func + (_ lhs: CGPoint, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return CGSize(width: lhs.x+rhs.0, height: lhs.y+rhs.1)
    }
    
    static func - (_ lhs: CGPoint, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.x-rhs.width, height: lhs.y-rhs.height)
    }
    
    static func - (_ lhs: CGPoint, _ rhs: CGPoint) -> CGSize {
        return CGSize(width: lhs.x-rhs.x, height: lhs.y-rhs.y)
    }
    
    static func - (_ lhs: CGPoint, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return CGSize(width: lhs.x-rhs.0, height: lhs.y-rhs.1)
    }
}

public extension CGRect {
    static func + (_ lhs: CGRect, _ rhs: CGSize) -> CGRect {
        return lhs.moved(offset: (rhs.width, rhs.height))
    }
    
    static func + (_ lhs: CGRect, _ rhs: CGPoint) -> CGRect {
        return lhs.moved(offset: (rhs.x, rhs.y))
    }
    
    static func + (_ lhs: CGRect, _ rhs: (CGFloat, CGFloat)) -> CGRect {
        return lhs.moved(offset: (rhs.0, rhs.1))
    }
    
    static func - (_ lhs: CGRect, _ rhs: CGSize) -> CGRect {
        return lhs.moved(offset: (-rhs.width, -rhs.height))
    }
    
    static func - (_ lhs: CGRect, _ rhs: CGPoint) -> CGRect {
        return lhs.moved(offset: (-rhs.x, -rhs.y))
    }
    
    static func - (_ lhs: CGRect, _ rhs: (CGFloat, CGFloat)) -> CGRect {
        return lhs.moved(offset: (-rhs.0, -rhs.1))
    }
    
    static func * (_ lhs: CGRect, _ rhs: CGSize) -> CGRect {
        return lhs.scaled(rate: (rhs.width, rhs.height))
    }
    
    static func * (_ lhs: CGRect, _ rhs: CGPoint) -> CGRect {
        return lhs.scaled(rate: (rhs.x, rhs.y))
    }
    
    static func * (_ lhs: CGRect, _ rhs: (CGFloat, CGFloat)) -> CGRect {
        return lhs.scaled(rate: (rhs.0, rhs.1))
    }
    
    static func / (_ lhs: CGRect, _ rhs: CGSize) -> CGRect {
        return lhs.scaled(rate: (1.0/rhs.width, 1.0/rhs.height))
    }
    
    static func / (_ lhs: CGRect, _ rhs: CGPoint) -> CGRect {
        return lhs.scaled(rate: (1.0/rhs.x, 1.0/rhs.y))
    }
    
    static func / (_ lhs: CGRect, _ rhs: (CGFloat, CGFloat)) -> CGRect {
        return lhs.scaled(rate: (1.0/rhs.0, 1.0/rhs.1))
    }
}

public extension CGRect {
    var center: CGPoint {
        get { return CGPoint(x: width/2+minX, y: height/2+minY) }
        set { origin = CGPoint(x: newValue.x-width/2, y: newValue.y-height/2) }
    }
    
    var left: CGFloat {
        get { return minX }
        set { origin = CGPoint(x: newValue, y: minY) }
    }
    
    var right: CGFloat {
        get { return maxX }
        set { origin = CGPoint(x: newValue-width, y: minY) }
    }
    
    var top: CGFloat {
        get { return minY }
        set { origin = CGPoint(x: minX, y: newValue) }
    }
    
    var bottom: CGFloat {
        get { return maxY }
        set { origin = CGPoint(x: minX, y: newValue-height) }
    }
    
    var leftTop: CGPoint {
        get { return origin }
        set { origin = newValue }
    }
    
    var rightTop: CGPoint {
        get { return CGPoint(x: maxX, y: minY) }
        set { origin = CGPoint(x: newValue.x-width, y: newValue.y) }
    }
    
    var leftBottom: CGPoint {
        get { return CGPoint(x: minX, y: maxY) }
        set { origin = CGPoint(x: newValue.x, y: newValue.y-height) }
    }
    
    var rightBottom: CGPoint {
        get { return CGPoint(x: maxX, y: maxY) }
        set { origin = CGPoint(x: newValue.x-width, y: newValue.y-height) }
    }
    
    var topCenter: CGPoint {
        return centerOfLine(point1: leftTop, point2: rightTop)
    }
    
    var bottomCenter: CGPoint {
        return centerOfLine(point1: leftBottom, point2: rightBottom)
    }
    
    var leftCenter: CGPoint {
        return centerOfLine(point1: leftTop, point2: leftBottom)
    }
    
    var rightCenter: CGPoint {
        return centerOfLine(point1: rightTop, point2: rightBottom)
    }
    
    var shortBorderLength: CGFloat {
        return min(width, height)
    }
    
    var longBorderLength: CGFloat {
        return max(width, height)
    }
    
    var hypotenuseLength: CGFloat {
        return sqrt(width*width + height*height)
    }
    
    var smallIntergal:CGRect {
        return CGRect(x: CGFloat(Int(nearDown: minX)),
                      y: CGFloat(Int(nearDown: minY)),
                      width: CGFloat(Int(nearDown: width)),
                      height: CGFloat(Int(nearDown: height)))
    }
    
    var neturalIntegal:CGRect {
        return CGRect(x: CGFloat(Int(nearCenter: minX)),
                      y: CGFloat(Int(nearCenter: minY)),
                      width: CGFloat(Int(nearCenter: width)),
                      height: CGFloat(Int(nearCenter: height)))
    }
}

public extension CGPoint {
    func opsitePoint(baseOf point:CGPoint) -> CGPoint {
        return CGPoint(x: 2*point.x - self.x, y: 2*point.y - self.y)
    }
}

public extension CGFloat {
    var intergal:CGFloat {
        return CGFloat(Int(nearUp: self))
    }
}

public extension Double {
    var intergal:Double {
        return Double(Int(nearUp: self))
    }
}

public extension Float {
    var intergal:Float {
        return Float(Int(nearUp: self))
    }
}

public extension CGPoint {
    var intergal:CGPoint {
        return CGPoint(x: x.intergal, y: y.intergal)
    }
}

public extension CGSize {
    var intergal:CGSize {
        return CGSize(width: width.intergal, height: height.intergal)
    }
}

public extension CGPoint {
    public func show() {
        let text = """
        Point
        \u{2190} \(self.x)
        \u{2193} \(self.y)
        """
        
        print(text)
    }
}

public extension CGSize {
    public func show() {
        let text = """
        Size
        \u{2194} \(self.width)
        \u{2195} \(self.height)
        """
        
        print(text)
    }
}

public extension CGRect {
    public func show() {
        let text = """
        Rect
        \u{2190} \(self.minX)
        \u{2193} \(self.minY)
        \u{2194} \(self.width)
        \u{2195} \(self.height)
        """
        
        print(text)
    }
}

public enum Direction : Int {
    case left
    case top
    case bottom
    case right
    case rightTop
    case rightBottom
    case leftTop
    case leftBottom
}

public extension CGRect {
    public func point(of dicrection:Direction) -> CGPoint {
        switch dicrection {
        case .left:
            return self.leftCenter
        case .top:
            return self.topCenter
        case .bottom:
            return self.bottomCenter
        case .right:
            return self.rightCenter
        case .rightTop:
            return self.rightTop
        case .leftTop:
            return self.leftTop
        case .rightBottom:
            return self.rightBottom
        case .leftBottom:
            return self.leftBottom
        }
    }
}

public extension CFRange {
    var nsRange:NSRange {
        return NSRange(location: location, length: length)
    }
}

public extension NSRange {
    var cfRange:CFRange {
        return CFRange(location: location, length: length)
    }
}

