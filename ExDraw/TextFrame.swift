//
//  TextFrame.swift
//  ExDraw
//
//  Created by 王渊鸥 on 2018/7/27.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import CoreText

public extension CTFrame {
    func draw(inContext:CGContext) {
        CTFrameDraw(self, inContext)
    }
    
    public static func create(byText text:NSAttributedString, point:CGPoint) -> CTFrame {
        let setter = CTFramesetter.create(byText: text)
        let size = text.size()
        let count = text.length
        return setter.lineFrame(charCount: count, rect: CGRect(origin: point, size: size))
    }
}

public extension CTFramesetter {
    public static func create(byText text:NSAttributedString) -> CTFramesetter {
        return CTFramesetterCreateWithAttributedString(text)
    }
    
    public func suggestSize(_ range:NSRange, size:CGSize) -> (NSRange, CGSize) {
        var retRagen = CFRange(location: 0, length: 0)
        let retSize = CTFramesetterSuggestFrameSizeWithConstraints(self, CFRange(location: range.location, length: range.length), nil, size, &retRagen)
        return (NSRange(location: retRagen.location, length: retRagen.length), retSize)
    }
    
    public func suggestPages(_ size:CGSize) -> [(NSRange, CGSize)] {
        var range = NSRange(location: 0, length: 10000)
        var sug = suggestSize(range, size: size)
        var ret:[(NSRange, CGSize)] = []
        while sug.0.length > 0 {
            ret += [sug]
            range = NSRange(location: sug.0.location+sug.0.length, length:10000)
            sug = suggestSize(range, size: size)
        }
        return ret
    }
    
    public func suggestFrames(_ size:CGSize) -> [CTFrame] {
        return suggestPages(size).map{
            let path = UIBezierPath()
            return CTFramesetterCreateFrame(self, CFRange(location: $0.0.location, length: $0.0.length), path.cgPath, nil)
        }
    }
    
    public func suggestRangerAndFrames(_ size:CGSize) -> [(NSRange, CTFrame)] {
        return suggestPages(size).map{
            let path = UIBezierPath()
            let frame = CTFramesetterCreateFrame(self, CFRange(location: $0.0.location, length: $0.0.length), path.cgPath, nil)
            return ($0.0, frame)
        }
    }
    
    public func lineFrame(charCount:Int, rect:CGRect) -> CTFrame {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.left, y: rect.height / 2.0))
        path.addLine(to: CGPoint(x: rect.right, y: rect.top + rect.height / 2.0))
        return CTFramesetterCreateFrame(self, CFRange(location: 0, length: charCount), path.cgPath, nil)
    }
}

