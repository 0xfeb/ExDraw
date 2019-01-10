//
//  Builder.swift
//  ExRect
//
//  Created by 王渊鸥 on 2018/7/18.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import CoreGraphics

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
