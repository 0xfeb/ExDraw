//
//  String.swift
//  ExDraw
//
//  Created by 王渊鸥 on 2018/7/26.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import ExType

public extension String {
    public func size(attribute: ExAttributes) -> CGSize {
        let astring = NSAttributedString(text: self, attribute: attribute)
        return astring.size().intergal
    }

    public func size(font: UIFont) -> CGSize {
        let attr = setup(ExAttributes()) {
            $0.font = font
        }
        return size(attribute: attr)
    }

    public func size(fitSize: CGSize, attribute: ExAttributes) -> CGSize {
        let astring = NSAttributedString(text: self, attribute: attribute)
        return astring.boundingRect(with: fitSize,
                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                    context: nil).size.intergal
    }

    public func size(fitSize: CGSize, font: UIFont, wordwarp: NSLineBreakMode, kern: CGFloat? = nil) -> CGSize {
        let attr = setup(ExAttributes()) {
            $0.font = font
            $0.lineBreakMode = wordwarp
            if let kern = kern {
                $0.kern = kern
            }
        }
        return size(fitSize:fitSize, attribute:attr)
    }
    
    public func image(attribute: ExAttributes, canvas: CGSize? = nil, textFrame: CGRect? = nil) -> UIImage {
        let canvas = canvas ?? size(attribute: attribute)
        let textFrame = textFrame ?? CGRect(origin: CGPoint.zero, size: canvas)
        return UIGraphicsImageRenderer(bounds: CGRect(x: 0, y: 0, width: canvas.width, height: canvas.height)).image { (context) in
            //UIGraphicsPushContext(context.cgContext)
            //context.cgContext.flipV(height: canvas.height)
            let astring = NSAttributedString(text: self, attribute: attribute)
            astring.draw(in: textFrame)
            //UIGraphicsPopContext()
        }
    }
}
