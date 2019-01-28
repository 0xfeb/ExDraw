//
//  GradientVC.swift
//  ExDrawDemo
//
//  Created by 王渊鸥 on 2019/1/18.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import ExDraw
import ExType

extension Direction {
    init?(byTag tag:Int) {
        switch tag {
        case 4:
            self = .left
        case 2:
            self = .top
        case 7:
            self = .bottom
        case 5:
            self = .right
        case 3:
            self = .rightTop
        case 8:
            self = .rightBottom
        case 1:
            self = .leftTop
        case 6:
            self = .leftBottom
        default:
            return nil
        }
    }
}

class PaintView : UIView {
    var color:[UIColor] = []
    var path:UIBezierPath!
    var direction:Direction? = nil
    
    override func draw(_ rect: CGRect) {
        if let gradient = CGGradient.colors(color), let context = UIGraphicsGetCurrentContext() {
            context.fill(gradient: gradient,
                         inRect: rect,
                     direction: direction,
                     inPath: path)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            path = UIBezierPath()
            path.move(to: point)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            path.addLine(to: point)
            
            self.setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        path.close()
        
        self.setNeedsDisplay()
    }
}

class GradientVC: UIViewController {
    @IBOutlet weak var paintView: PaintView!
    @IBOutlet weak var colorText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        setupActionButton()
    }
    
    func setupColors() {
        guard let colorsString = colorText.text else { return }
        let colors:[UIColor] = colorsString
            .components(separatedBy: ",")
            .compactMap({ (rgbText:String) -> UIColor? in
                let rgbs = rgbText
                    .split(size:2)
                    .map({ CGFloat(Int(hex:$0))/255.0 })
                if rgbs.count < 3 { return nil }
                return UIColor(red: rgbs[0], green: rgbs[1], blue: rgbs[2], alpha: 1.0)
        })
        
        if colors.count > 2 {
            paintView.color = colors
        }
    }
    
    func setupActionButton() {
        let button = UIBarButtonItem(title: "Save Image", style: .done, target: self, action:
            #selector(onClickAction))
        self.navigationItem.setRightBarButton(button, animated: true)
    }
    
    @objc func onClickAction() {
        if let gradient = CGGradient.colors(paintView.color) {
            let image = UIImage.gradientImage(gradient, screen: paintView.frame.size, direction: paintView.direction, inPath: paintView.path)
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }

    @IBAction func onChangeText(_ sender: UITextField) {
        setupColors()
    }
    
    @IBAction func onClickDirection(_ sender: UIButton) {
        let direction = Direction(byTag: sender.tag)
        paintView.direction = direction
    }
}

