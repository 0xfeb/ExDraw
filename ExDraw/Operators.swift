//
//  Operators.swift
//  ExRect
//
//  Created by 王渊鸥 on 2018/7/18.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation

public extension CGSize {
    static func + (_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return ex_size(lhs.width+rhs.width, lhs.height+rhs.height)
    }

    static func + (_ lhs: CGSize, _ rhs: CGPoint) -> CGSize {
        return ex_size(lhs.width+rhs.x, lhs.height+rhs.y)
    }

    static func + (_ lhs: CGSize, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return ex_size(lhs.width+rhs.0, lhs.height+rhs.1)
    }

    static func - (_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return ex_size(lhs.width-rhs.width, lhs.height-rhs.height)
    }

    static func - (_ lhs: CGSize, _ rhs: CGPoint) -> CGSize {
        return ex_size(lhs.width-rhs.x, lhs.height-rhs.y)
    }

    static func - (_ lhs: CGSize, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return ex_size(lhs.width-rhs.0, lhs.height-rhs.1)
    }

    static func * (_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return ex_size(lhs.width*rhs.width, lhs.height*rhs.height)
    }

    static func * (_ lhs: CGSize, _ rhs: CGPoint) -> CGSize {
        return ex_size(lhs.width*rhs.x, lhs.height*rhs.y)
    }

    static func * (_ lhs: CGSize, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return ex_size(lhs.width*rhs.0, lhs.height*rhs.1)
    }

    static func / (_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return ex_size(lhs.width/rhs.width, lhs.height/rhs.height)
    }

    static func / (_ lhs: CGSize, _ rhs: CGPoint) -> CGSize {
        return ex_size(lhs.width/rhs.x, lhs.height/rhs.y)
    }

    static func / (_ lhs: CGSize, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return ex_size(lhs.width/rhs.0, lhs.height/rhs.1)
    }
}

public extension CGPoint {
    static func + (_ lhs: CGPoint, _ rhs: CGSize) -> CGSize {
        return ex_size(lhs.x+rhs.width, lhs.y+rhs.height)
    }

    static func + (_ lhs: CGPoint, _ rhs: CGPoint) -> CGSize {
        return ex_size(lhs.x+rhs.x, lhs.y+rhs.y)
    }

    static func + (_ lhs: CGPoint, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return ex_size(lhs.x+rhs.0, lhs.y+rhs.1)
    }

    static func - (_ lhs: CGPoint, _ rhs: CGSize) -> CGSize {
        return ex_size(lhs.x-rhs.width, lhs.y-rhs.height)
    }

    static func - (_ lhs: CGPoint, _ rhs: CGPoint) -> CGSize {
        return ex_size(lhs.x-rhs.x, lhs.y-rhs.y)
    }

    static func - (_ lhs: CGPoint, _ rhs: (CGFloat, CGFloat)) -> CGSize {
        return ex_size(lhs.x-rhs.0, lhs.y-rhs.1)
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
