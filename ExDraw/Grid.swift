//
//  Grid.swift
//  ExRect
//
//  Created by 王渊鸥 on 2018/7/22.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGRect {
    public func buildGrids(rowCount: Int, itemsInRow: Int,
                           edge: UIEdgeInsets = UIEdgeInsets.zero,
                           hSpace: CGFloat = 0, vSpace: CGFloat = 0) -> [CGRect] {
        if rowCount == 0 || itemsInRow == 0 {
            return []
        }

        var result: [CGRect] = []
        let gridWidth = (width - edge.left - edge.right - hSpace * CGFloat(itemsInRow - 1)) / CGFloat(itemsInRow)
        let gridHeight = (height - edge.top - edge.bottom - vSpace * CGFloat(rowCount - 1)) / CGFloat(rowCount)
        for vPosition in 0..<rowCount {
            let gridTop = edge.top + CGFloat(vPosition) * (gridHeight + vSpace)
            for hPostion in 0..<itemsInRow {
                let gridLeft = edge.left + CGFloat(hPostion) * (gridWidth + hSpace)
                result.append(ex_rect(gridLeft, gridTop, gridWidth, gridHeight))
            }
        }

        return result
    }

    public struct HeightWidthRate {
        public var heightDWidth: CGFloat
        public var constant: CGFloat

        public func widthOf(height: CGFloat) -> CGFloat {
            return (height - constant) / heightDWidth
        }

        public func heightOf(width: CGFloat) -> CGFloat {
            return heightDWidth * width + constant
        }
    }

    public func buildHFlowGrids(rowCount: Int, hwRate: HeightWidthRate, itemsCount: Int,
                                edge: UIEdgeInsets = UIEdgeInsets.zero,
                                hSpace: CGFloat = 0, vSpace: CGFloat = 0) -> [CGRect] {
        if rowCount == 0 {
            return []
        }

        let itemsInRow = itemsCount / rowCount

        var result: [CGRect] = []
        let gridHeight = (height - edge.top - edge.bottom - CGFloat(rowCount - 1) * vSpace ) / CGFloat(rowCount)
        let gridWidth = hwRate.widthOf(height: gridHeight)

        for vPosition in 0..<rowCount {
            let gridTop = edge.top + CGFloat(vPosition) * (gridHeight + vSpace)
            for hPostion in 0..<itemsInRow {
                let gridLeft = edge.left + CGFloat(hPostion) * (gridWidth + hSpace)
                result.append(ex_rect(gridLeft, gridTop, gridWidth, gridHeight))
            }
        }

        return result
    }

    public func buildVFlowGrids(itemsInRow: Int, hwRate: HeightWidthRate, itemsCount: Int,
                                edge: UIEdgeInsets = UIEdgeInsets.zero,
                                hSpace: CGFloat = 0, vSpace: CGFloat = 0) -> [CGRect] {
        if itemsInRow == 0 {
            return []
        }

        let rowCount = itemsCount / itemsInRow

        var result: [CGRect] = []
        let gridWidth = (width - edge.left - edge.right - CGFloat(itemsInRow - 1) * hSpace) / CGFloat(itemsInRow)
        let gridHeight = hwRate.heightOf(width: gridWidth)

        for vPostion in 0..<rowCount {
            let gridTop = edge.top + CGFloat(vPostion) * (gridHeight + vSpace)
            for hPosition in 0..<itemsInRow {
                let gridLeft = edge.left + CGFloat(hPosition) * (gridWidth + hSpace)
                result.append(ex_rect(gridLeft, gridTop, gridWidth, gridHeight))
            }
        }

        return result
    }

    public func itemAtHFlowGrids(rowCount: Int, hwRate: HeightWidthRate, item: Int,
                                 edge: UIEdgeInsets = UIEdgeInsets.zero,
                                 hSpace: CGFloat = 0, vSpace: CGFloat = 0) -> CGRect {
        if rowCount == 0 {
            return CGRect.zero
        }

        let gridHeight = (height - edge.top - edge.bottom - CGFloat(rowCount - 1) * vSpace ) / CGFloat(rowCount)
        let gridWidth = hwRate.widthOf(height: gridHeight)

        let hPosition = item / rowCount
        let vPosition = item % rowCount

        let gridTop = edge.top + CGFloat(vPosition) * (gridHeight + vSpace)
        let gridLeft = edge.left + CGFloat(hPosition) * (gridWidth + hSpace)

        return ex_rect(gridLeft, gridTop, gridWidth, gridHeight)
    }

    public func itemAtVFlowGrids(itemsInRow: Int, hwRate: HeightWidthRate, item: Int,
                                 edge: UIEdgeInsets = UIEdgeInsets.zero,
                                 hSpace: CGFloat = 0, vSpace: CGFloat = 0) -> CGRect {
        if itemsInRow == 0 {
            return CGRect.zero
        }

        let gridWidth = (width - edge.left - edge.right - CGFloat(itemsInRow - 1) * hSpace) / CGFloat(itemsInRow)
        let gridHeight = hwRate.heightOf(width: gridWidth)

        let hPosition = item % itemsInRow
        let vPosition = item / itemsInRow

        let gridTop = edge.top + CGFloat(vPosition) * (gridHeight + vSpace)
        let gridLeft = edge.left + CGFloat(hPosition) * (gridWidth + hSpace)

        return ex_rect(gridLeft, gridTop, gridWidth, gridHeight)
    }
}
