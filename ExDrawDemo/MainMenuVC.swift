//
//  MainMenuVC.swift
//  ExDrawDemo
//
//  Created by 王渊鸥 on 2019/1/18.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit

struct MenuItem {
    var name:String
    var targetId:String
}

let menus = [
    MenuItem(name:"Gradient", targetId:"GradientVC"),
    MenuItem(name:"SimpleGrid", targetId:"SimpleGridVC"),
    MenuItem(name:"CollectionGrid", targetId:"CollectionGridVC"),
    MenuItem(name:"Path", targetId:"PathVC"),
    MenuItem(name:"String", targetId:"StringVC"),
    MenuItem(name:"TextFrame", targetId:"TextFrameVC"),
    MenuItem(name:"AttributedString", targetId:"AttributedStringVC")
]

let cellName = "MenuCell"

class MainMenuVC: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName) ?? UITableViewCell(style: .default, reuseIdentifier: cellName)
        cell.textLabel?.text = menus[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: menus[indexPath.row].targetId) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
