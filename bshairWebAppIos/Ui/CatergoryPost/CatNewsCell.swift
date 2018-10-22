//
//  CatNewsCell.swift
//  bshairWebAppIos
//
//  Created by johar on 10/22/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit

class CatNewsCell: UITableViewCell {
    @IBOutlet weak var newsImageCat: UIImageView!
    @IBOutlet weak var newsTitleCat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
