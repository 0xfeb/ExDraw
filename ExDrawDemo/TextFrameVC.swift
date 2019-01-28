//
//  TextFrameVC.swift
//  ExDrawDemo
//
//  Created by 王渊鸥 on 2019/1/18.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import ExDraw
import ExType

class TextFrameVC: UIViewController {
    @IBOutlet weak var containerView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupContainer()
        setupActionButton()
    }

    func setupContainer() {
        let resList = ["1.txt", "2.rtf", "3.jpg", "4.rtfd", "5.html"]
        for res in resList {
            let filename = String.bundlePath.appendPath(res)
            if let attrString = NSAttributedString(filename: filename) {
                containerView.attributedText += attrString + attrString
            }
            
        }
    }
    
    func setupActionButton() {
        let actionButton = UIBarButtonItem(title: "Frame", style: .done, target: self, action: #selector(onClickAction))
        navigationItem.rightBarButtonItem = actionButton
    }
    
    @objc func onClickAction() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FrameDrawVC") as? FrameDrawVC {
            vc.text = containerView.attributedText/*.applied(add: setup(ExAttributes(), {
                $0.lineBreakMode = NSLineBreakMode.byWordWrapping
                $0.lineSpacing = 5
            }))*/

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
//        print(containerView.attributedText.length)
//        frameSetter = CTFramesetter.create(byText: containerView.attributedText)
//        let pair = frameSetter!.cut(inScreen: self.view.bounds.size, range: nil)
//        print(pair)
    }
}
