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
        get { return ex_point(width/2+minX, height/2+minY) }
        set { origin = ex_point(newValue.x-width/2, newValue.y-height/2) }
    }

    var left: CGFloat {
        get { return minX }
        set { origin = ex_point(newValue, minY) }
    }

    var right: CGFloat {
        get { return maxX }
        set { origin = ex_point(newValue-width, minY) }
    }

    var top: CGFloat {
        get { return minY }
        set { origin = ex_point(minX, newValue) }
    }

    var bottom: CGFloat {
        get { return maxY }
        set { origin = ex_point(minX, newValue-height) }
    }

    var leftTop: CGPoint {
        get { return origin }
        set { origin = newValue }
    }

    var rightTop: CGPoint {
        get { return ex_point(maxX, minY) }
        set { origin = ex_point(newValue.x-width, newValue.y) }
    }

    var leftBottom: CGPoint {
        get { return ex_point(minX, maxY) }
        set { origin = ex_point(newValue.x, newValue.y-height) }
    }

    var rightBottom: CGPoint {
        get { return ex_point(maxX, maxY) }
        set { origin = ex_point(newValue.x-width, newValue.y-height) }
    }

    var topCenter: CGPoint {
        return ex_center(point1: leftTop, point2: rightTop)
    }

    var bottomCenter: CGPoint {
        return ex_center(point1: leftBottom, point2: rightBottom)
    }

    var leftCenter: CGPoint {
        return ex_center(point1: leftTop, point2: leftBottom)
    }

    var rightCenter: CGPoint {
        return ex_center(point1: rightTop, point2: rightBottom)
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
