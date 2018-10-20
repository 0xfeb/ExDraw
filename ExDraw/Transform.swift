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
        origin = ex_point(origin.x + offset.0, origin.y + offset.1)
    }

    public func moved(offset: (CGFloat, CGFloat)) -> CGRect {
        return ex_rect(origin.x + offset.0, origin.y + offset.1, width, height)
    }

    public mutating func clip(edge: UIEdgeInsets) {
        origin = ex_point(minX+edge.left, minY+edge.top)
        size = ex_size(width-edge.left-edge.right, height-edge.top-edge.bottom)
    }

    public func cliped(edge: UIEdgeInsets) -> CGRect {
        return ex_rect(minX+edge.left, minY+edge.top, width-edge.left-edge.right, height-edge.top-edge.bottom)
    }

    public func scaled(size: (CGFloat, CGFloat)) -> CGRect {
        return CGRect(center: center, size: ex_size(self.size.width+size.0, self.size.height+size.1))
    }

    public func scaled(rate: (CGFloat, CGFloat)) -> CGRect {
        return CGRect(center: center, size: ex_size(self.size.width*rate.0, self.size.height*rate.1))
    }

    public mutating func scale(size: (CGFloat, CGFloat)) {
        let originCenter = center
        self.size = ex_size(self.size.width+size.0, self.size.height+size.1)
        self.center = originCenter
    }

    public mutating func scale(rate: (CGFloat, CGFloat)) {
        let originCenter = center
        self.size = ex_size(self.size.width*rate.0, self.size.height*rate.1)
        self.center = originCenter
    }

    //Get ralation rect of this one
    public var innerSqure: CGRect {
        let length = min(width, height)
        return CGRect(center: center, size: ex_size(length, length))
    }

    public var outterSqure: CGRect {
        let length = max(width, height)
        return CGRect(center: center, size: ex_size(length, length))
    }

    public var innerCycle: CGRect {
        return outterSqure
    }

    public var outterCycle: CGRect {
        let opsiteCornerLength = sqrt(width*width + height*height)
        return CGRect(center: center, size: ex_size(opsiteCornerLength, opsiteCornerLength))
    }

    //Cut rect to depart it
    public func devided(from edge: CGRectEdge, fix: CGFloat) -> (CGRect, CGRect) {
        switch edge {
        case .minXEdge:
            let rect1 = ex_rect(left, top, fix, height)
            let rect2 = ex_rect(left+fix, top, width-fix, height)
            return (rect1, rect2)
        case .maxXEdge:
            let rect1 = ex_rect(right-fix, top, fix, height)
            let rect2 = ex_rect(left, top, width-fix, height)
            return (rect1, rect2)
        case .minYEdge:
            let rect1 = ex_rect(left, top, width, fix)
            let rect2 = ex_rect(left, top+fix, width, height-fix)
            return (rect1, rect2)
        case .maxYEdge:
            let rect1 = ex_rect(left, bottom-fix, width, fix)
            let rect2 = ex_rect(left, top, width, height-fix)
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
            return ex_rect(left, top, size.width, size.height)
        case .leftBottom:
            return ex_rect(left, bottom-size.height, size.width, size.height)
        case .rightTop:
            return ex_rect(right-size.width, top, size.width, size.height)
        case .rightBottom:
            return ex_rect(right-size.width, bottom-size.height, size.width, size.height)
        case .center:
            return ex_rect(center.x-size.width/2, center.y-size.height/2, size.width, size.height)
        }
    }

    public mutating func resizeBaseCenter(width: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.center, size: ex_size(width, size.height))
    }

    public mutating func resizeBaseCenter(height: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.center, size: ex_size(size.width, height))
    }

    public mutating func resizeBaseLeft(width: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.leftTop, size: ex_size(width, size.height))
    }

    public mutating func resizeBaseRight(width: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.rightTop, size: ex_size(width, size.height))
    }

    public mutating func resizeBaseTop(height: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.leftTop, size: ex_size(size.width, height))
    }

    public mutating func resizeBaseBottom(height: CGFloat) {
        resize(fixCorner: CGRect.RectCorner.leftBottom, size: ex_size(size.width, height))
    }

    public func resizedBaseCenter(width: CGFloat) -> CGRect {
        return resized(fixCorner: CGRect.RectCorner.center, size: ex_size(width, size.height))
    }

    public func resizedBaseCenter(height: CGFloat) -> CGRect {
        return resized(fixCorner: CGRect.RectCorner.center, size: ex_size(size.width, height))
    }

    public func resizedBaseLeft(width: CGFloat) -> CGRect {
        return resized(fixCorner: CGRect.RectCorner.leftTop, size: ex_size(size.width, height))
    }

    public func resizedBaseRight(width: CGFloat) -> CGRect {
        return resized(fixCorner: CGRect.RectCorner.leftBottom, size: ex_size(size.width, height))
    }

    public func resizedBaseTop(height: CGFloat) -> CGRect {
        return  resized(fixCorner: CGRect.RectCorner.leftTop, size: ex_size(size.width, height))
    }

    public func resizedBaseBottom(height: CGFloat) -> CGRect {
        return resized(fixCorner: CGRect.RectCorner.leftBottom, size: ex_size(size.width, height))
    }

    public func fliped(based: CGRectEdge) -> CGRect {
        switch based {
        case .minXEdge:
            return ex_rect(left - width, top, width, height)
        case .maxXEdge:
            return ex_rect(right, top, width, height)
        case .minYEdge:
            return ex_rect(left, top - height, width, height)
        case .maxYEdge:
            return ex_rect(left, bottom, width, height)
        }
    }
}
