//
//  Grid.swift
//  ExRect
//
//  Created by 王渊鸥 on 2018/7/22.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import CoreGraphics

public struct GridGap {
    var border:CGSize
    var gap:CGSize
    
    public init(border:CGSize, gap:CGSize) {
        self.border = border
        self.gap = gap
    }
}

public struct ExGrid {
    var screen:CGSize
    var itemCountInRow:Int
    var rateHeight:CGFloat
    var fixHeight:CGFloat
    var gap:GridGap
    
    public func itemHeight(rate:CGFloat, fix:CGFloat) -> ExGrid {
        return ExGrid(screen: screen,
                      itemCountInRow: itemCountInRow,
                      rateHeight: rate,
                      fixHeight: fix,
                      gap: gap)
    }
    
    public func gap(border:CGSize, gap:CGSize) -> ExGrid {
        return ExGrid(screen: screen,
                      itemCountInRow: itemCountInRow,
                      rateHeight: rateHeight,
                      fixHeight: fixHeight,
                      gap: GridGap(border: border, gap: gap))
    }
    
    public func grid(at position:Int) -> CGRect {
        let width = (screen.width - 2.0 * gap.border.width - CGFloat(itemCountInRow - 1) * gap.gap.width)/CGFloat(itemCountInRow)
        let height = width * rateHeight + fixHeight
        
        let xPos = position % itemCountInRow
        let yPos = position / itemCountInRow
        
        let x = gap.border.width + CGFloat(xPos) * (width + gap.gap.width)
        let y = gap.border.height + CGFloat(yPos) * (height + gap.gap.height)
        
        return CGRect(x: x, y: y, width: width, height: height).smallIntergal
    }
}

public extension CGSize {
    public func buildGrids(itemCountInRow:Int) -> ExGrid? {
        if itemCountInRow < 1 { return nil }
        return ExGrid(screen: self,
                      itemCountInRow: itemCountInRow,
                      rateHeight: 1,
                      fixHeight: 0,
                      gap: GridGap(border: CGSize.zero, gap: CGSize.zero))
    }
}
