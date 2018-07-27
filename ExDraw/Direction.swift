//
//  Direction.swift
//  ExDraw
//
//  Created by 王渊鸥 on 2018/7/26.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import ExRect

public enum ExDirection {
    case toTop
    case toTopRight
    case toTopLeft
    case toRight
    case toBottomRight
    case toBottom
    case toBottomLeft
    case toLeft

    var opsite: ExDirection {
        switch self {
        case .toBottom:
            return ExDirection.toTop
        case .toTop:
            return ExDirection.toBottom
        case .toLeft:
            return ExDirection.toRight
        case .toRight:
            return ExDirection.toLeft
        case .toTopLeft:
            return ExDirection.toBottomRight
        case .toTopRight:
            return ExDirection.toBottomLeft
        case .toBottomLeft:
            return ExDirection.toTopRight
        case .toBottomRight:
            return ExDirection.toTopLeft
        }
    }

    func point(of rect: CGRect) -> CGPoint {
        switch self {
        case .toTop:
            return ex_point(rect.center.x, rect.top)
        case .toTopRight:
            return rect.rightTop
        case .toTopLeft:
            return rect.leftTop
        case .toRight:
            return ex_point(rect.right, rect.center.y)
        case .toBottomRight:
            return rect.rightBottom
        case .toBottom:
            return ex_point(rect.center.x, rect.bottom)
        case .toBottomLeft:
            return rect.leftBottom
        case .toLeft:
            return ex_point(rect.left, rect.center.y)
        }
    }
}
