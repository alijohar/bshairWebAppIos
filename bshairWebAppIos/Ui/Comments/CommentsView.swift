//
//  CommentsView.swift
//  bshairWebAppIos
//
//  Created by johar on 10/21/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit

class CommentsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var authorName:String?
    var dateComment:String?
    var newsContent:String?
    var arrayComments = [NewsComments]()
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell: CommentsCell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentsCell
        myCell.authorName.text = arrayComments[indexPath.row].name
        myCell.date.text = arrayComments[indexPath.row].date
        myCell.commentContent.text = arrayComments[indexPath.row].content
        
        return myCell
    }

}
