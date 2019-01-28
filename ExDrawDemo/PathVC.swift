//
//  PathVC.swift
//  ExDrawDemo
//
//  Created by 王渊鸥 on 2019/1/18.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import ExDraw
import ExType

class PenPaintView : UIView {
    var lineWidth:CGFloat = 2.0
    var last:CGPoint = CGPoint.zero
    var path:UIBezierPath?
    
    override func draw(_ rect: CGRect) {
        UIColor.red.setStroke()
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(lineWidth)
        
        if let path = path {
            context?.addPath(path.cgPath)
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
    }
    
    func restorePath(path:CGPath) {
        self.path = UIBezierPath(cgPath: path)
        self.setNeedsDisplay()
    }
    
    func drawPoint(point:CGPoint) {
        path?.addLine(to: point)
        
        let rect = CGRect(point1: last, point2: point).expand(size: (5, 5))
        self.setNeedsDisplay(rect)
        
        last = point
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            last = touch.location(in: self)
            
            path = UIBezierPath()
            path?.move(to: last)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            
            drawPoint(point: point)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            
            drawPoint(point: point)
        }
    }
}

class PathVC: UIViewController {
    @IBOutlet weak var paintView: PenPaintView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActionButton()
        restorePath()
    }
    
    func restorePath() {
        let file = String.documentsPath.appendPath("old.path")
        if let text = try? String(contentsOfFile: file) {
            let path = CGPath.from(text: text)
            paintView.restorePath(path: path)
        }
    }
    
    func setupActionButton() {
        let action = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(onClickAction))
        self.navigationItem.rightBarButtonItem = action
    }
    
    @objc func onClickAction() {
        if let text = paintView.path?.cgPath.text {
            let file = String.documentsPath.appendPath("old.path")
            try! text.write(toFile: file, atomically: true, encoding: String.Encoding.utf8)
        }
    }
    
    @IBAction func onChangePenWidth(_ sender: UISlider) {
        paintView.lineWidth = CGFloat(sender.value)
    }
}
