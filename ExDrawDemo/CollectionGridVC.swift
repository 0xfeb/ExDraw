//
//  CollectionGridVC.swift
//  ExDrawDemo
//
//  Created by 王渊鸥 on 2019/1/18.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import ExDraw
import ExType

private let reuseIdentifier = "TestCell"

class CollectionGridVC: UICollectionViewController {
    var dataList:[String] = (0..<102).map({ "Value:\($0)" })

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let layout = UIScreen.main.bounds.size
            .buildGrids(itemCountInRow: 3)!
            .itemHeight(rate: 1.2, fix: 20)
            .gap(border: CGSize(width: 16, height: 16), gap: CGSize(width: 8, height: 8))
            .collectionViewLayout
        
        self.collectionView.collectionViewLayout = layout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        cell.backgroundColor = UIColor.red
    
        return cell
    }
}
