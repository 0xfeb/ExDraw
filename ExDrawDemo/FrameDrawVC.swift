//
//  FrameDrawVC.swift
//  ExDrawDemo
//
//  Created by 王渊鸥 on 2019/1/23.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import CoreText
import ExType
import ExDraw

class FrameDrawView : UIView {
    var content:CTFrame!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print(content)
        
        CGContext.current?.flipV(height: rect.height)
        content.draw()
    }
}

class FrameDrawVC: UIViewController {
    var text:NSAttributedString!
    @IBOutlet weak var containerView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupFrame()
    }
    
    func setupFrame() {
        let screenSize = self.containerView.bounds.size + (0, self.containerView.contentOffset.y)
        let startRect = CGRect(origin: CGPoint.zero, size: screenSize).expand(size: (-10, -17))
        let builder = ExFrameBuilder(text: text, screenSize: startRect.size)
        
        for n in 0..<builder.ranges.count {
            let content = builder.frame(at: UInt(n))
            let rect = startRect.moved(offset: (screenSize.width*CGFloat(n), 0))
            let view = FrameDrawView(frame: rect)
            view.content = content
            view.isOpaque = false
            view.backgroundColor = UIColor.red
            
            containerView.addSubview(view)
        }
        
        containerView.contentSize = screenSize * (CGFloat(builder.ranges.count), CGFloat(1))
    }
}
