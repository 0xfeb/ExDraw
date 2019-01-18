//
//  ExDrawTests.swift
//  ExDrawTests
//
//  Created by 王渊鸥 on 2019/1/10.
//  Copyright © 2019 WangYuanOu. All rights reserved.
//

import XCTest
import ExDraw
import ExType

class ExDrawTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLine() {
        let point1 = CGPoint(x: 10, y: 10)
        let point2 = CGPoint(x: 30, y: 30)
        
        XCTAssertEqual(CGPoint(x: 20, y: 20), centerOfLine(point1: point1, point2: point2))
        XCTAssertTrue(CGFloat(28.284271247461901) ~ lengthOfLine(point1: point1, point2: point2))
        XCTAssertEqual(CGFloat.pi / 4.0, angleOfLine(point1: point1, point2: point2))
    }

    func testAngle() {
        XCTAssertEqual(CGFloat.pi/4, radianOfDegree(45))
        XCTAssertEqual(45, degreeOfRadian(CGFloat.pi/4))
    }
    
    func testRectCreate() {
        let rect = CGRect(x: 50, y: 100, width: 200, height: 300)
        XCTAssertEqual(rect, CGRect(center: CGPoint(x: 150, y: 250), size: CGSize(width: 200, height: 300)))
        XCTAssertEqual(rect, CGRect(leftTop: CGPoint(x: 50, y: 100), size: CGSize(width: 200, height: 300)))
        XCTAssertEqual(rect, CGRect(rightTop: CGPoint(x: 250, y: 100), size: CGSize(width: 200, height: 300)))
        XCTAssertEqual(rect, CGRect(leftBottom: CGPoint(x: 50, y: 400), size: CGSize(width: 200, height: 300)))
        XCTAssertEqual(rect, CGRect(rightBottom: CGPoint(x: 250, y: 400), size: CGSize(width: 200, height: 300)))
        XCTAssertEqual(rect, CGRect(point1: CGPoint(x: 50, y: 100), point2: CGPoint(x: 250, y: 400)))
        XCTAssertEqual(rect, CGRect(point1: CGPoint(x: 250, y: 100), point2: CGPoint(x: 50, y: 400)))
    }
    
    func testRectProp() {
        let rect = CGRect(x: 50, y: 100, width: 200, height: 300)
        XCTAssertEqual(CGPoint(x:150, y:250), rect.center)
        XCTAssertEqual(CGPoint(x: 50, y: 100), rect.leftTop)
        XCTAssertEqual(CGPoint(x: 50, y: 400), rect.leftBottom)
        XCTAssertEqual(CGPoint(x: 250, y: 100), rect.rightTop)
        XCTAssertEqual(CGPoint(x: 250, y: 400), rect.rightBottom)
    }
//
//    func testGrids(){
//        let item = CGSize(width: 1000, height: 1000)
//            .buildGrids(itemCountInRow: 3)?
//            .itemHeight(rate: 1.2, fix: 30)
//            .gap(border: CGSize(width: 16, height: 16), gap: CGSize(width: 8, height: 8))
//            .grid(at: 20)
//
//        XCTAssertEqual(CGRect.zero, item)
//    }
    
    func testTransform() {
        XCTAssertEqual(CGRect(x: 20, y: 20, width: 200, height: 200), CGRect(x: 0, y: 0, width: 200, height: 200).moved(offset: (20, 20)))
        XCTAssertEqual(CGRect(x: 20, y: 20, width: 160, height: 160), CGRect(x: 0, y: 0, width: 200, height: 200).cliped(edge: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)))
        XCTAssertEqual(CGRect(x: 50, y: 50, width: 100, height: 100), CGRect(x: 0, y: 0, width: 200, height: 200).scaled(rate: (0.5, 0.5)))
        XCTAssertEqual(CGRect(x: 50, y: 50, width: 100, height: 100), CGRect(x: 0, y: 0, width: 200, height: 200).expand(size: (-100, -100)))
        XCTAssertEqual(CGRect(x: 50, y: 0, width: 100, height: 100), CGRect(x: 0, y: 0, width: 200, height: 100).innerSqure)
        XCTAssertEqual(CGRect(x: 0, y: -50, width: 200, height: 200), CGRect(x: 0, y: 0, width: 200, height: 100).outterSqure)
        XCTAssertEqual(CGRect(x: -11, y: -61, width: 224, height: 224), CGRect(x: 0, y: 0, width: 200, height: 100).outterCycle.neturalIntegal)
    }
    
    func testCut() {
        XCTAssertTrue((CGRect(x: 0, y: 0, width: 50, height: 100),
                        CGRect(x: 50, y: 0, width: 150, height: 100)) ==
                       CGRect(x: 0, y: 0, width: 200, height: 100).cuted(edge: CGRectEdge.minXEdge, cut:50))
        
        XCTAssertTrue((CGRect(x: 150, y: 0, width: 50, height: 100),
                       CGRect(x: 0, y: 0, width: 150, height: 100)) ==
            CGRect(x: 0, y: 0, width: 200, height: 100).cuted(edge: CGRectEdge.maxXEdge, cut:50))
        
        XCTAssertTrue((CGRect(x: 0, y: 0, width: 200, height: 50),
                       CGRect(x: 0, y: 50, width: 200, height: 50)) ==
            CGRect(x: 0, y: 0, width: 200, height: 100).cuted(edge: CGRectEdge.minYEdge, cut:50))
        
        XCTAssertTrue((CGRect(x: 0, y: 50, width: 200, height: 50),
                       CGRect(x: 0, y: 0, width: 200, height: 50)) ==
            CGRect(x: 0, y: 0, width: 200, height: 100).cuted(edge: CGRectEdge.maxYEdge, cut:50))
        
        XCTAssertTrue((CGRect(x: 0, y: 0, width: 50, height: 100),
                       CGRect(x: 50, y: 0, width: 150, height: 100)) ==
            CGRect(x: 0, y: 0, width: 200, height: 100).cuted(edge: CGRectEdge.minXEdge, cutRate:0.25))
        
        XCTAssertTrue((CGRect(x: 150, y: 0, width: 50, height: 100),
                       CGRect(x: 0, y: 0, width: 150, height: 100)) ==
            CGRect(x: 0, y: 0, width: 200, height: 100).cuted(edge: CGRectEdge.maxXEdge, cutRate:0.25))
        
        XCTAssertTrue((CGRect(x: 0, y: 0, width: 200, height: 50),
                       CGRect(x: 0, y: 50, width: 200, height: 50)) ==
            CGRect(x: 0, y: 0, width: 200, height: 100).cuted(edge: CGRectEdge.minYEdge, cutRate:0.5))
        
        XCTAssertTrue((CGRect(x: 0, y: 50, width: 200, height: 50),
                       CGRect(x: 0, y: 0, width: 200, height: 50)) ==
            CGRect(x: 0, y: 0, width: 200, height: 100).cuted(edge: CGRectEdge.maxYEdge, cutRate:0.5))
    }
    
    func testResize() {
        XCTAssertEqual(CGRect(x: 50, y: 50, width: 100, height: 100), CGRect(x: 0, y: 0, width: 200, height: 200).resized(fixCorner: .center, size: CGSize(width: 100, height: 100)))
        XCTAssertEqual(CGRect(x: 0, y: 0, width: 100, height: 100), CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertEqual(CGRect(x: 100, y: 100, width: 100, height: 100), CGRect(x: 0, y: 0, width: 200, height: 200).resized(fixCorner: .rightBottom, size: CGSize(width: 100, height: 100)))
        XCTAssertEqual(CGRect(x: 0, y: 100, width: 100, height: 100), CGRect(x: 0, y: 0, width: 200, height: 200).resized(fixCorner: .leftBottom, size: CGSize(width: 100, height: 100)))
        XCTAssertEqual(CGRect(x: 100, y: 0, width: 100, height: 100), CGRect(x: 0, y: 0, width: 200, height: 200).resized(fixCorner: .rightTop, size: CGSize(width: 100, height: 100)))
    }
    
    func testFliped() {
        let origin = CGRect(x: 50, y: 50, width: 100, height: 100)
        
        XCTAssertEqual(rect(-50, 50, 100, 100), origin.fliped(by: .minXEdge))
        XCTAssertEqual(rect(150, 50, 100, 100), origin.fliped(by: .maxXEdge))
        XCTAssertEqual(rect(50, -50, 100, 100), origin.fliped(by: .minYEdge))
        XCTAssertEqual(rect(50, 150, 100, 100), origin.fliped(by: .maxYEdge))
    }
    
    func testDirection() {
        let origin = rect(50, 100, 400, 200)
        
        XCTAssertEqual(origin.leftTop, origin.rightBottom.opsitePoint(baseOf:origin.center))
    }
}
