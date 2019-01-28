//
//  AttributedString.swift
//  ExDraw
//
//  Created by 王渊鸥 on 2018/7/26.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import ExType

public class ExAttributes {
    public enum LineWidth: Int {
        case none = 0x00
        case single = 0x01
        case thick = 0x02
        case double = 0x09
    }

    public enum LineStyle: Int {
        case solid = 0x000
        case dot = 0x0100
        case dash = 0x0200
        case dashDot = 0x0300
        case dashDotDot = 0x0400
    }

    public var font:UIFont?
    public var textColor:UIColor?
    public var backColor:UIColor?
    public var ligature:Bool?  //连体符
    public var kern:CGFloat?   //字间距
    public var strikethrough:(LineWidth, LineStyle, UIColor)?  //删除线
    public var underline:(LineWidth, LineStyle, UIColor)?      //下划线
    public var textStroke:(CGFloat, UIColor)?      //文字描边
    public var shadow:NSShadow?
    public var attachment:NSTextAttachment?        //附件
    public var baseline:CGFloat?                   //基线
    public var expansion:CGFloat?                  //横向拉伸
    public var link:URL?         //外链
    public var obliqueness:CGFloat?    //倾斜度,+右,-左
    public var vertical:Bool?      //竖排文本

    public var alignment:NSTextAlignment?
    public var firstLineHeadIndent:CGFloat?
    public var headIndent:CGFloat?
    public var tailIndent:CGFloat?
    public var lineBreakMode:NSLineBreakMode?
    public var maximumLineHeight:CGFloat?
    public var minimumLineHeight:CGFloat?
    public var lineSpacing:CGFloat?
    public var paragraphSpacing:CGFloat?
    public var paragraphSpacingBefore:CGFloat?
    public var baseWritingDirection:NSWritingDirection?
    public var lineHeightMultiple:CGFloat?
    public var defaultTabInterval:CGFloat?

    public init() {}

    public init(image: UIImage, size: CGSize?) {
        attachment = NSTextAttachment()
        attachment?.image = image
        if let size = size {
            attachment?.bounds = CGRect(origin: .zero, size: size)
        } else {
            let imageSize = image.size
            let drawSize = CGSize(width:imageSize.width/UIScreen.main.scale, height:imageSize.height/UIScreen.main.scale)
            attachment?.bounds = CGRect(origin: .zero, size: drawSize)
        }
    }

    // 将文本属性生成系统所属的字典
    public var dict: [NSAttributedString.Key: AnyObject] {
        var result:[NSAttributedString.Key: AnyObject] = [:]
        if let font = self.font { result[NSAttributedString.Key.font] = font }
        if let textColor = self.textColor { result[NSAttributedString.Key.foregroundColor] = textColor }
        if let backColor = self.backColor { result[NSAttributedString.Key.backgroundColor] = backColor }
        if let ligature = self.ligature { result[NSAttributedString.Key.ligature] = NSNumber(value: ligature ? 1:0 as Int) }
        if let kern = self.kern { result[NSAttributedString.Key.kern] = NSNumber(value: Float(kern) as Float) }
        if let strikethrough = self.strikethrough {
            result[NSAttributedString.Key.underlineColor] = strikethrough.2
            result[NSAttributedString.Key.underlineStyle] = NSNumber(value: strikethrough.0.rawValue + strikethrough.1.rawValue as Int)
        }
        if let underline = self.underline {
            result[NSAttributedString.Key.underlineColor] = underline.2
            result[NSAttributedString.Key.underlineStyle] = NSNumber(value: underline.0.rawValue + underline.1.rawValue as Int)
        }
        if let textStroke = self.textStroke {
            result[NSAttributedString.Key.strokeWidth] = NSNumber(value: Float(textStroke.0) as Float)
            result[NSAttributedString.Key.strokeColor] = textStroke.1
        }
        if let shadow = self.shadow { result[NSAttributedString.Key.shadow] = shadow }
        if let attachment = self.attachment { result[NSAttributedString.Key.attachment] = attachment }
        if let baseline = self.baseline { result[NSAttributedString.Key.baselineOffset] = NSNumber(value: Float(baseline) as Float) }
        if let expansion = self.expansion { result[NSAttributedString.Key.expansion] = NSNumber(value: Float(expansion) as Float) }
        if let link = self.link { result[NSAttributedString.Key.link] = link as AnyObject? }
        if let obliqueness = self.obliqueness { result[NSAttributedString.Key.obliqueness] = obliqueness as AnyObject? }
        if let vertical = self.vertical { result[NSAttributedString.Key.verticalGlyphForm] = NSNumber(value: vertical ? 1:0 as Int) }
        var style:NSMutableParagraphStyle? = nil
        if let alignment = self.alignment {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.alignment = alignment
        }
        if let firstLineHeadIndent = self.firstLineHeadIndent {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.firstLineHeadIndent = firstLineHeadIndent
        }
        if let headIndent = self.headIndent {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.headIndent = headIndent
        }
        if let tailIndent = self.tailIndent {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.tailIndent = tailIndent
        }
        if let lineBreakMode = self.lineBreakMode {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.lineBreakMode = lineBreakMode
        }
        if let maximumLineHeight = self.maximumLineHeight {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.maximumLineHeight = maximumLineHeight
        }
        if let minimumLineHeight = self.minimumLineHeight {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.minimumLineHeight = minimumLineHeight
        }
        if let lineSpacing = self.lineSpacing {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.lineSpacing = lineSpacing
        }
        if let paragraphSpacing = self.paragraphSpacing {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.paragraphSpacing = paragraphSpacing
        }
        if let paragraphSpacingBefore = self.paragraphSpacingBefore {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.paragraphSpacingBefore = paragraphSpacingBefore
        }
        if let baseWritingDirection = self.baseWritingDirection {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.baseWritingDirection = baseWritingDirection
        }
        if let lineHeightMultiple = self.lineHeightMultiple {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.lineHeightMultiple = lineHeightMultiple
        }
        if let defaultTabInterval = self.defaultTabInterval {
            if nil == style { style = NSMutableParagraphStyle() }
            style?.defaultTabInterval = defaultTabInterval
        }
        if let style = style { result[NSAttributedString.Key.paragraphStyle] = style }
        
        return result
    }

    // 合成新的属性
    func combine(_ attr: ExAttributes) -> ExAttributes {
        if let font = attr.font { self.font = font }
        if let textColor = attr.textColor { self.textColor = textColor }
        if let backColor = attr.backColor { self.backColor = backColor }
        if let ligature = attr.ligature { self.ligature = ligature }
        if let kern = attr.kern { self.kern = kern }
        if let strikethrough = attr.strikethrough { self.strikethrough = strikethrough }
        if let underline = attr.underline { self.underline = underline }
        if let textStroke = attr.textStroke { self.textStroke = textStroke }
        if let shadow = attr.shadow { self.shadow = shadow }
        if let attachment = attr.attachment { self.attachment = attachment }
        if let baseline = attr.baseline { self.baseline = baseline }
        if let expansion = attr.expansion { self.expansion = expansion }
        if let link = attr.link { self.link = link }
        if let obliqueness = attr.obliqueness { self.obliqueness = obliqueness }
        if let vertical = attr.vertical { self.vertical = vertical }
        if let alignment = attr.alignment { self.alignment = alignment }
        if let firstLineHeadIndent = attr.firstLineHeadIndent { self.firstLineHeadIndent = firstLineHeadIndent }
        if let headIndent = attr.headIndent { self.headIndent = headIndent }
        if let tailIndent = attr.tailIndent { self.tailIndent = tailIndent }
        if let lineBreakMode = attr.lineBreakMode { self.lineBreakMode = lineBreakMode }
        if let maximumLineHeight = attr.maximumLineHeight { self.maximumLineHeight = maximumLineHeight }
        if let minimumLineHeight = attr.minimumLineHeight { self.minimumLineHeight = minimumLineHeight }
        if let lineSpacing = attr.lineSpacing { self.lineSpacing = lineSpacing }
        if let paragraphSpacing = attr.paragraphSpacing { self.paragraphSpacing = paragraphSpacing }
        if let paragraphSpacingBefore = attr.paragraphSpacingBefore { self.paragraphSpacingBefore = paragraphSpacingBefore }
        if let baseWritingDirection = attr.baseWritingDirection { self.baseWritingDirection = baseWritingDirection }
        if let lineHeightMultiple = attr.lineHeightMultiple { self.lineHeightMultiple = lineHeightMultiple }
        if let defaultTabInterval = attr.defaultTabInterval { self.defaultTabInterval = defaultTabInterval }

        return self
    }

    public static func + (attr0: ExAttributes, attr1: ExAttributes) -> ExAttributes {
        return attr0.combine(attr1)
    }

    public static func += (attr0: inout ExAttributes, attr1: ExAttributes) {
        attr0 = attr0 + attr1
    }

    public var imageString : NSAttributedString? {
        if let attach = attachment {
            return NSAttributedString(attachment: attach)
        }
        return nil
    }
}

public extension NSAttributedString {
    public convenience init(text: String, attribute: ExAttributes) {
        let dict = attribute.dict
        self.init(string: text, attributes: dict)
    }

    public convenience init(text: String, font: UIFont, color: UIColor, backColor: UIColor? = nil) {
        let attr = ExAttributes()
        attr.font = font
        attr.textColor = color
        attr.backColor = backColor
        self.init(text: text, attribute: attr)
    }

    public static func + (s0: NSAttributedString, s1: NSAttributedString) -> NSAttributedString {
        let s = NSMutableAttributedString(attributedString: s0)
        s.append(s1)
        return s
    }

    public static func += (s0:inout NSAttributedString, s1:NSAttributedString) {
        s0 = s0 + s1
    }
    
    public convenience init?(htmlText text:String) {
        let options:[NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType : NSAttributedString.DocumentType.html//,
            //.characterEncoding : String.Encoding.utf8
        ]
        if let data = text.data(using: .utf8, allowLossyConversion: true), let str = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            self.init(attributedString: str)
        } else {
            return nil
        }
    }
    
    public convenience init?(rtfFile fileName:String) {
        let options:[NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType : NSAttributedString.DocumentType.rtf,
            .characterEncoding : String.Encoding.utf8
        ]
        if let url = URL(auto:fileName), let str = try? NSAttributedString(url: url, options: options, documentAttributes: nil) {
            self.init(attributedString: str)
        } else {
            return nil
        }
    }
    
    public convenience init?(rtfDFile filename:String) {
        let options:[NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType : NSAttributedString.DocumentType.rtfd,
            .characterEncoding : String.Encoding.utf8
        ]
        if let url = URL(auto:filename), let str = try? NSAttributedString(url: url, options: options, documentAttributes: nil) {
            self.init(attributedString: str)
        } else {
            return nil
        }
    }
    
    public convenience init?(image:UIImage, size:CGSize? = nil) {
        let imageSize = size ?? image.size
        let attr = ExAttributes(image: image, size: imageSize)
        if let str = attr.imageString {
            self.init(attributedString: str)
        } else {
            return nil
        }
    }
    
    //support files: txt(default), rtfd, rtf, htm, html, png, jpg, jpeg
    public convenience init?(filename:String) {
        let ext = filename.pathExtension
        switch ext {
        case "rtfd":
            self.init(rtfDFile: filename)
        case "rtf":
            self.init(rtfFile: filename)
        case "html", "htm":
            guard let text = try? String(contentsOfFile: filename) else { return nil }
            self.init(htmlText: text)
        case "jpg", "jpeg", "png":
            guard let image = UIImage(contentsOfFile: filename) else { return nil }
            self.init(image: image)
        default:
            guard let text = try? String(contentsOfFile: filename) else { return nil }
            let attr = ExAttributes()
            attr.font = UIFont.systemFont(ofSize: 14)
            attr.textColor = UIColor.darkGray
            self.init(text: text, attribute: attr)
        }
    }
    
    public func applied(add attribute:ExAttributes, range:NSRange? = nil) -> NSAttributedString {
        let range = range ?? NSRange(location: 0, length: length)
        
        let result = NSMutableAttributedString(attributedString: self)
        result.addAttributes(attribute.dict, range: range)
        
        return result
    }
    
    public func applied(change attribute:ExAttributes, range:NSRange? = nil) -> NSAttributedString {
        let range = range ?? NSRange(location: 0, length: length)
        
        let result = NSMutableAttributedString(attributedString: self)
        result.setAttributes(attribute.dict, range: range)
        
        return result
    }
    
    public func size(inWidth:CGFloat) -> CGSize {
        let containerSize = CGSize(width: inWidth, height: 0)
        let calulateSize = boundingRect(with: containerSize, options: [.usesLineFragmentOrigin, .usesFontLeading, .truncatesLastVisibleLine, .usesDeviceMetrics], context: nil).integral.size
        return CGSize(width: calulateSize.width, height: calulateSize.height + 16)
        
        //16 is the default textContainerInset top add bottom(both are 8)
    }
}

