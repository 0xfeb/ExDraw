//
//  Builder.swift
//  ExRect
//
//  Created by 王渊鸥 on 2018/7/18.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import CoreGraphics

// ----- Simple way to build mesure units -----
public func ex_rect(_ left: CGFloat, _ top: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: left, y: top, width: width, height: height)
}

public func ex_point(_ xValue: CGFloat, _ yValue: CGFloat) -> CGPoint {
    return CGPoint(x: xValue, y: yValue)
}

public func ex_size(_ width: CGFloat, _ height: CGFloat) -> CGSize {
    return CGSize(width: width, height: height)
}

// ----- Center of two points -----
public func ex_center(point1: CGPoint, point2: CGPoint) -> CGPoint {
    let xValue = (point1.x + point2.x)/2
    let yValue = (point1.y + point2.y)/2
    return ex_point(xValue, yValue)
}

public func ex_length(point1: CGPoint, point2: CGPoint) -> CGFloat {
    let xDistance = point1.x - point2.x
    let yDistance = point1.y - point2.y
    return sqrt(xDistance*xDistance + yDistance*yDistance)
}

public func ex_angle(point1: CGPoint, point2: CGPoint) -> CGFloat {
    return atan2(point2.y - point1.y, point2.x - point1.x)
}

public extension CGRect {
    public init(center point: CGPoint, size: CGSize) {
        let origin = ex_point(point.x - size.width/2, point.y - size.height/2)
        self.init(origin: origin, size: size)
    }

    public init(leftTop point: CGPoint, size: CGSize) {
        self.init(origin: point, size: size)
    }

    public init(rightTop point: CGPoint, size: CGSize) {
        let origin = ex_point(point.x - size.width, point.y)
        self.init(origin: origin, size: size)
    }

    public init(leftBottom point: CGPoint, size: CGSize) {
        let origin = ex_point(point.x, point.y - size.height)
        self.init(origin: origin, size: size)
    }

    public init(rightBottom point: CGPoint, size: CGSize) {
        let origin = ex_point(point.x - size.width, point.y - size.height)
        self.init(origin: origin, size: size)
    }

    //Make a rect from two points
    public init(point1: CGPoint, point2: CGPoint) {
        let origin = ex_point(min(point1.x, point2.x), min(point1.y, point2.y))
        let size = ex_size(abs(point1.x-point2.x), abs(point1.y-point2.y))
        self.init(origin: origin, size: size)
    }
}
