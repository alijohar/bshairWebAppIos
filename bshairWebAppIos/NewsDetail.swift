//
//  NewsDetail.swift
//  bshairWebAppIos
//
//  Created by johar on 9/18/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit

class NewsDetail: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize navigationBar
        setupNavigationBarItems()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupNavigationBarItems(){
        navigationItem.title = "افتتاح مسجد جديد"
        let shareNewsButton = UIButton(type: .system)
        shareNewsButton.setImage(#imageLiteral(resourceName: "shareNews"), for: .normal)
        shareNewsButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        let addCommentsButton = UIButton(type: .system)
        addCommentsButton.setImage(#imageLiteral(resourceName: "addComment"), for: .normal)
        addCommentsButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: shareNewsButton), UIBarButtonItem(customView: addCommentsButton)]
        
    }


}
