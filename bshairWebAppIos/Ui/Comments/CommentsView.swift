//
//  CommentsView.swift
//  bshairWebAppIos
//
//  Created by johar on 10/21/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit

class CommentsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var heightForRow:CGFloat = 120.0
    var authorName:String?
    var dateComment:String?
    var newsContent:String?
    var arrayComments = [NewsComments]()
    var newsItemId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addCommentsButton = UIButton(type: .system)
        addCommentsButton.setImage(#imageLiteral(resourceName: "addComment"), for: .normal)
        addCommentsButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addCommentsButton.addTarget(self, action: #selector(CommentsView.sendCommentButton(_:)), for: UIControlEvents.touchUpInside)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: addCommentsButton)]

    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell: CommentsCell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentsCell
        myCell.authorName.text = arrayComments[indexPath.row].name
        myCell.date.text = arrayComments[indexPath.row].date
        setCommentContent(myCell: myCell, indexPath: indexPath)
        
        return myCell
    }
    
    @objc func sendCommentButton(_ sender : UIButton){
        let alertController = UIAlertController(title: "أرسل تعليقاً", message: "", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "إرسال", style: .destructive) { (_) in
            
            //getting the input values from user
            
            //            post id should add here
            let post_id = self.newsItemId
            
            
            guard let name = alertController.textFields?[0].text, !name.isEmpty else {return}
            guard let email = alertController.textFields?[1].text, !email.isEmpty else {return}
            guard let content = alertController.textFields?[2].text, !content.isEmpty else {return}
            
            NewsApi.sendComment(post_id: post_id!, name: name, email: email, content: content) {(error:Error?, success:Bool) in
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func setCommentContent(myCell: CommentsCell, indexPath: IndexPath){
        var text = "<head><style type=\"text/css\">\n" +
            "@font-face {\n" +
            " font-family: 'MyCustomFont';\n" +
            "}\n" +
            "\n" +
            "\n" +
            "body{\n" +
            "  color:  #6f7179;\n" +
            "  text-align: justify;\n" +
            "  direction: rtl;\n" +
            "  line-height: 2.5;\n" +
            "}\n" +
            "\n" +
            "img{\n" +
            "  height: auto;\n" +
            "  width: 100%;\n" +
            "  display: block;\n" +
            "  margin-left: auto;\n" +
            "  margin-right: auto;\n" +
            "}\n" +
            "\n" +
            "h1, h2, h3, h4, h5, h5 {\n" +
            "  color: red;\n" +
            "  text-align: center;\n" +
        "}</style>\n\n</head><html><body dir=\"rtl\"; style=\"text-align:justify;\">"
        
        text = text + arrayComments[indexPath.row].content!
        text = text + "</body></html>"
        myCell.commentContent.loadHTMLString(text, baseURL: nil)

    }

}
