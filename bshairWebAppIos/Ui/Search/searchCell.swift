//
//  searchCell.swift
//  bshairWebAppIos
//
//  Created by johar on 10/20/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit

class searchCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
