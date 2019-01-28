//
//  AttributedStringVC.swift
//  ExDrawDemo
//
//  Created by 王渊鸥 on 2019/1/18.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import ExDraw
import CoreText

class AttributedStringVC: UIViewController {
    @IBOutlet weak var contentView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
        setupAction()
    }
    
    func setupContent() {
        let files = ["1.txt", "2.rtf", "3.jpg", "4.rtfd", "5.html"]
        
        for file in files {
            let filename = String.bundlePath.appendPath(file)
            contentView.attributedText += NSAttributedString(text: "\n>>>> \(filename)\n", font: UIFont.boldSystemFont(ofSize: 16), color: UIColor.blue)
            
            if let attrString = NSAttributedString(filename: filename) {
                contentView.attributedText += attrString
            }
        }
    }
    
    func setupAction() {
        let actionButton = UIBarButtonItem(title: "Size", style: .done, target: self, action: #selector(onClickAction))
        self.navigationItem.rightBarButtonItem = actionButton
    }
    
    @objc func onClickAction() {
        let size = contentView.attributedText.size()
        let contentSize = contentView.contentSize
        let trueSize = contentView.attributedText.size(inWidth: contentView.bounds.width)
//        let formatter = CTFramesetter.create(byText: contentView.attributedText)
//        let formatterSize = formatter.cut(inScreen: contentView.frame.size, range: nil)
        let containerSize = contentView.frame.size
        
        let alert = UIAlertController(title: "Size", message: "Size -> \(size)\n\n\nTrue size -> \(trueSize)\n\n\nContent Size -> \(contentSize)\n\n\nContainer Size -> \(containerSize)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
}
