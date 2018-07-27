//
//  String.swift
//  ExDraw
//
//  Created by 王渊鸥 on 2018/7/26.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import ExType
import ExRect

public extension String {
    public func size(attribute: ExAttributes) -> CGSize {
        let astring = self.attributeString(attribute)
        return astring.size()
    }

    public func size(font: UIFont) -> CGSize {
        let attr = ex_set(ExAttributes()) {
            $0.font = font
        }
        return size(attribute: attr)
    }

    public func size(fitSize: CGSize, attribute: ExAttributes) -> CGSize {
        let astring = self.attributeString(attribute)
        return astring.boundingRect(with: fitSize,
                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                    context: nil).size
    }

    public func size(fitSize: CGSize, font: UIFont, wordwarp: NSLineBreakMode, kern: CGFloat? = nil) -> CGSize {
        let attr = ex_set(ExAttributes()) {
            $0.font = font
            $0.lineBreakMode = wordwarp
            if let kern = kern {
                $0.kern = kern
            }
        }
        return size(fitSize:fitSize, attribute:attr)
    }
    
    public func image(canvasSize: CGSize, textFrame: CGRect, attribute: ExAttributes) -> UIImage {
        return UIGraphicsImageRenderer(bounds: ex_rect(0, 0, canvasSize.width, canvasSize.height)).image { (context) in
            UIGraphicsPushContext(context.cgContext)
            context.cgContext.flipV(height: canvasSize.height)
            let astring = self.attributeString(attribute)
            astring.draw(in: textFrame)
            UIGraphicsPopContext()
        }
    }
}
