//
//  NewsDetail.swift
//  bshairWebAppIos
//
//  Created by johar on 9/18/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsDetail: UIViewController {
    var navTitle:String?
    var newsItemId:Int?
    
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
        navigationItem.title = navTitle
        let shareNewsButton = UIButton(type: .system)
        shareNewsButton.setImage(#imageLiteral(resourceName: "shareNews"), for: .normal)
        shareNewsButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        let addCommentsButton = UIButton(type: .system)
        addCommentsButton.setImage(#imageLiteral(resourceName: "addComment"), for: .normal)
        addCommentsButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addCommentsButton.addTarget(self, action: #selector(NewsDetail.sendCommentButton(_:)), for: UIControlEvents.touchUpInside)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: shareNewsButton), UIBarButtonItem(customView: addCommentsButton)]
        
    }
    
    
    @objc func sendCommentButton(_ sender : UIButton){
        let alertController = UIAlertController(title: "أرسل تعليقاً", message: "", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "إرسال", style: .destructive) { (_) in
            
            //getting the input values from user
            
//            post id should add here
            let post_id = "586"
            
            guard let name = alertController.textFields?[0].text, !name.isEmpty else {return}
            guard let email = alertController.textFields?[1].text, !email.isEmpty else {return}
            guard let content = alertController.textFields?[2].text, !content.isEmpty else {return}
            
            NewsApi.sendComment(post_id: post_id, name: name, email: email, content: content) {(error:Error?, success:Bool) in
                if success {
                    print("success")
                }else{
                    print("error")
                }
                
            }
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "إلغاء", style: .default) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "الاسم الكريم"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "البريد الإلكتروني"
        }
        alertController.addTextField{ (textField) in
            textField.placeholder = "نص الرسالة"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)

    }

    


}
