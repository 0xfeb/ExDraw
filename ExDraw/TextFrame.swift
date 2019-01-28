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
    func draw(inContext context:CGContext? = nil ) {
        if let context = context ?? CGContext.current {
            CTFrameDraw(self, context)
        }
    }
//
//    public static func create(byText text:NSAttributedString, point:CGPoint) -> CTFrame {
//        let setter = CTFramesetter.create(byText: text)
//        let size = text.size()
//        let count = text.length
//        return setter.lineFrame(charCount: count, rect: CGRect(origin: point, size: size))
//    }
}

public class ExFrameBuilder {
    var text:NSAttributedString
    var setter:CTFramesetter
    var screenSize:CGSize
    public var ranges:[CFRange] = []
    
    public init(text:NSAttributedString, screenSize:CGSize) {
        self.text = text
        self.screenSize = screenSize
        setter = CTFramesetterCreateWithAttributedString(text)
        
        self.cut()
    }
    
    private func fit(position:Int) -> CFRange {
        var retRange = CFRange()
        let fromRange = CFRange(location: position, length: text.length - position)
        _ = CTFramesetterSuggestFrameSizeWithConstraints(setter, fromRange, nil, screenSize, &retRange)
        return retRange
    }
    
    public func cut() {
        ranges = []

        var range = fit(position: 0)
        while range.length > 0 {
            ranges.append(range)
            range = fit(position: range.location+range.length)
        }
    }
    
    public func frame(at:UInt) -> CTFrame? {
        if at >= ranges.count {
            return nil
        }
        
        let range = ranges[Int(at)]
        return CTFramesetterCreateFrame(setter, range, CGPath(rect: CGRect(origin: CGPoint.zero, size: screenSize), transform: nil), nil)
    }
}
//
//public extension CTFramesetter {
//    public static func create(byText text:NSAttributedString) -> CTFramesetter {
//        return CTFramesetterCreateWithAttributedString(text)
//    }
//
//    public func cut(inScreen size:CGSize, range:NSRange?) -> NSRange {
//        var retRagen = CFRange()
//        let range = range ?? NSRange(location: 0, length: 0)
//        _ = CTFramesetterSuggestFrameSizeWithConstraints(self, range.cfRange, nil, size, &retRagen)
//        return retRagen.nsRange
//    }
//
//    public func cutPages(inScreen size:CGSize) -> [NSRange] {
//        var result:[NSRange] = []
//
//        var cutRange = cut(inScreen: size, range: NSRange(location: 0, length: 0))
//        while cutRange.length > 0 {
//            result.append(cutRange)
//            let nextRange = NSRange(location: cutRange.location+cutRange.length, length: 0)
//            cutRange = cut(inScreen: size, range: nextRange)
//        }
//
//        return result
//    }
//
//    public func framesFrom(ranges:[NSRange]) -> [CTFrame] {
//        var result:[CTFrame] = []
//        for range in ranges {
//            result.append(CTFramesetterCreateFrame(self,
//                                                   range.cfRange,
//                                                   UIBezierPath().cgPath,
//                                                   nil))
//        }
//        return result
//    }
//
//    public func lineFrame(charCount:Int, rect:CGRect) -> CTFrame {
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: rect.left, y: rect.height / 2.0))
//        path.addLine(to: CGPoint(x: rect.right, y: rect.top + rect.height / 2.0))
//        return CTFramesetterCreateFrame(self, CFRange(location: 0, length: charCount), path.cgPath, nil)
//    }
//}

