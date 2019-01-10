//
//  Parts.swift
//  ExRect
//
//  Created by 王渊鸥 on 2018/7/18.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import CoreGraphics

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
}
