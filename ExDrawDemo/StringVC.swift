//
//  StringVC.swift
//  ExDrawDemo
//
//  Created by 王渊鸥 on 2019/1/18.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import ExType
import ExDraw

class StringVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAction()
    }
    
    func setupAction() {
        let action = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(onClickAction))
        navigationItem.rightBarButtonItem = action
    }
    
    @objc func onClickAction() {
        let attr = setup(ExAttributes(), { (attr) in
            attr.font = textField.font
        })
        if let image = textField.text?.image(attribute: attr) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
    @IBAction func onChangeText(_ sender: UITextField) {
        if let text = sender.text {
            let size = text.size(font: sender.font ?? UIFont.systemFont(ofSize: 14))
            sizeLabel.text = "Size -> \(size)"
        }
    }
    
}
