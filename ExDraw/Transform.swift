//
//  Transform.swift
//  ExRect
//
//  Created by 王渊鸥 on 2018/7/18.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import UIKit

public extension CGRect {
    public mutating func move(offset: (CGFloat, CGFloat)) {
        origin = CGPoint(x: origin.x + offset.0, y: origin.y + offset.1)
    }

    public func moved(offset: (CGFloat, CGFloat)) -> CGRect {
        return CGRect(x: origin.x + offset.0, y: origin.y + offset.1, width: width, height: height)
    }

    public mutating func clip(edge: UIEdgeInsets) {
        origin = CGPoint(x: minX+edge.left, y: minY+edge.top)
        size = CGSize(width: width-edge.left-edge.right, height: height-edge.top-edge.bottom)
    }

    public func cliped(edge: UIEdgeInsets) -> CGRect {
        return CGRect(x: minX+edge.left, y: minY+edge.top, width: width-edge.left-edge.right, height: height-edge.top-edge.bottom)
    }

    public func scaled(size: (CGFloat, CGFloat)) -> CGRect {
        return CGRect(center: center, size: CGSize(width: self.size.width+size.0, height: self.size.height+size.1))
    }

    public func scaled(rate: (CGFloat, CGFloat)) -> CGRect {
        return CGRect(center: center, size: CGSize(width: self.size.width*rate.0, height: self.size.height*rate.1))
    }

    public mutating func scale(size: (CGFloat, CGFloat)) {
        let originCenter = center
        self.size = CGSize(width: self.size.width+size.0, height: self.size.height+size.1)
        self.center = originCenter
    }

    public mutating func scale(rate: (CGFloat, CGFloat)) {
        let originCenter = center
        self.size = CGSize(width: self.size.width*rate.0, height: self.size.height*rate.1)
        self.center = originCenter
    }

    //Get ralation rect of this one
    public var innerSqure: CGRect {
        let length = min(width, height)
        return CGRect(center: center, size: CGSize(width: length, height: length))
    }

    public var outterSqure: CGRect {
        let length = max(width, height)
        return CGRect(center: center, size: CGSize(width: length, height: length))
    }

    public var innerCycle: CGRect {
        return outterSqure
    }

    public var outterCycle: CGRect {
        let opsiteCornerLength = sqrt(width*width + height*height)
        return CGRect(center: center, size: CGSize(width: opsiteCornerLength, height: opsiteCornerLength))
    }

    //Cut rect to depart it
    public func devided(from edge: CGRectEdge, fix: CGFloat) -> (CGRect, CGRect) {
        switch edge {
        case .minXEdge:
            let rect1 = CGRect(x: left, y: top, width: fix, height: height)
            let rect2 = CGRect(x: left+fix, y: top, width: width-fix, height: height)
            return (rect1, rect2)
        case .maxXEdge:
            let rect1 = CGRect(x: right-fix, y: top, width: fix, height: height)
            let rect2 = CGRect(x: left, y: top, width: width-fix, height: height)
            return (rect1, rect2)
        case .minYEdge:
            let rect1 = CGRect(x: left, y: top, width: width, height: fix)
            let rect2 = CGRect(x: left, y: top+fix, width: width, height: height-fix)
            return (rect1, rect2)
        case .maxYEdge:
            let rect1 = CGRect(x: left, y: bottom-fix, width: width, height: fix)
            let rect2 = CGRect(x: left, y: top, width: width, height: height-fix)
            return (rect1, rect2)
        }
    }

    //rate from 0 to 1, if use 0.5, to cut from center
    public func devided(from edge: CGRectEdge, rate: CGFloat) -> (CGRect, CGRect) {
        var fix: CGFloat = 0
        switch edge {
        case .minXEdge, .maxXEdge:
            fix = width * rate
        case .minYEdge, .maxYEdge:
            fix = height * rate
        }
        return devided(from: edge, fix: fix)
    }

    enum RectCorner {
        case leftTop
        case rightTop
        case leftBottom
        case rightBottom
        case center
    }

    //Resize by fix origin
    public mutating func resize(fixCorner: RectCorner, size: CGSize) {
        switch fixCorner {
        case .leftTop:
            self.size = size
        case .leftBottom:
            let originLeftBottom = leftBottom
            self.size = size
            self.leftBottom = originLeftBottom
        case .rightTop:
            let originRightTop = rightTop
            self.size = size
            self.rightTop = originRightTop
        case .rightBottom:
            let originRightBottom = rightBottom
            self.size = size
            self.rightBottom = originRightBottom
        case .center:
            let originCenter = center
            self.size = size
            self.center = originCenter
        }
    }

    public func resized(fixCorner: RectCorner, size: CGSize) -> CGRect {
        switch fixCorner {
        case .leftTop:
            return CGRect(x: left, y: top, width: size.width, height: size.height)
        case .leftBottom:
            return CGRect(x: left, y: bottom-size.height, width: size.width, height: size.height)
        case .rightTop:
            return CGRect(x: right-size.width, y: top, width: size.width, height: size.height)
        case .rightBottom:
            return CGRect(x: right-size.width, y: bottom-size.height, width: size.width, height: size.height)
        case .center:
            return CGRect(x: center.x-size.width/2, y: center.y-size.height/2, width: size.width, height: size.height)
        }
    }

    public mutating func resizeBaseCenter(width: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.center, size: CGSize(width: width, height: size.height))
    }

    public mutating func resizeBaseCenter(height: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.center, size: CGSize(width: size.width, height: height))
    }

    public mutating func resizeBaseLeft(width: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.leftTop, size: CGSize(width: width, height: size.height))
    }

    public mutating func resizeBaseRight(width: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.rightTop, size: CGSize(width: width, height: size.height))
    }

    public mutating func resizeBaseTop(height: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.leftTop, size: CGSize(width: size.width, height: height))
    }

    public mutating func resizeBaseBottom(height: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.leftBottom, size: CGSize(width: size.width, height: height))
    }

    public func resizedBaseCenter(width: CGFloat) -> CGRect {
        return resized(fixCorner: CGRect.RectCorner.center, size: CGSize(width: width, height: size.height))
    }

    public func resizedBaseCenter(height: CGFloat) -> CGRect {
        return resized(fixCorner: CGRect.RectCorner.center, size: CGSize(width: size.width, height: height))
    }

    public func resizedBaseLeft(width: CGFloat) -> CGRect {
        return resized(fixCorner: CGRect.RectCorner.leftTop, size: CGSize(width: size.width, height: height))
    }

    public func resizedBaseRight(width: CGFloat) -> CGRect {
        return resized(fixCorner: CGRect.RectCorner.leftBottom, size: CGSize(width: size.width, height: height))
    }

    public func resizedBaseTop(height: CGFloat) -> CGRect {
        return  resized(fixCorner: CGRect.RectCorner.leftTop, size: CGSize(width: size.width, height: height))
    }

    public func resizedBaseBottom(height: CGFloat) -> CGRect {
        return resized(fixCorner: CGRect.RectCorner.leftBottom, size: CGSize(width: size.width, height: height))
    }

    public func fliped(based: CGRectEdge) -> CGRect {
        switch based {
        case .minXEdge:
            return CGRect(x: left - width, y: top, width: width, height: height)
        case .maxXEdge:
            return CGRect(x: right, y: top, width: width, height: height)
        case .minYEdge:
            return CGRect(x: left, y: top - height, width: width, height: height)
        case .maxYEdge:
            return CGRect(x: left, y: bottom, width: width, height: height)
        }
    }
}
