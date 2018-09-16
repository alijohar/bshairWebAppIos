//
//  ViewController.swift
//  bshairWebAppIos
//
//  Created by johar on 9/16/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add NavigationBar
        setupNavigationBarItems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupNavigationBarItems(){
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "bshair_menu_logo2"))
        titleImageView.contentMode = UIViewContentMode.scaleAspectFit
        navigationItem.titleView = titleImageView

//        add background
self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bk")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .tile), for: .default)
    }

}

