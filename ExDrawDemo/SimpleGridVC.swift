//
//  SimpleGridVC.swift
//  ExDrawDemo
//
//  Created by 王渊鸥 on 2019/1/18.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import ExDraw

class SimpleGridVC: UIViewController {
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCells()
    }

    func setupCells() {
        let grid = contentView
            .frame
            .size
            .buildGrids(itemCountInRow: 3)?
            .gap(border: ExDraw.size(16, 16), gap: ExDraw.size(8, 8))
            .itemHeight(rate: 1.2, fix: 20)
        
        let _ = (0..<102)
            .map({ (id) -> UIView in
                let rect = grid?.grid(at: id) ?? CGRect.zero
                
                let view = UIView(frame: rect)
                let color = UIColor(red: CGFloat.random(in: 0...1),
                                    green: CGFloat.random(in: 0...1),
                                    blue: CGFloat.random(in: 0...1),
                                    alpha: 1.0)
                view.backgroundColor = color
                view.tag = id
                contentView.addSubview(view)
                
                return view
            })
        
        
        let height = grid?.height(count:102) ?? 0
        contentHeight.constant = height
    }
}
