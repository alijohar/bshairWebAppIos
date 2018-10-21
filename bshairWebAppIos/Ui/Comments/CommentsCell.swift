//
//  CommentsCell.swift
//  bshairWebAppIos
//
//  Created by johar on 10/21/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var commentContent: UIWebView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
