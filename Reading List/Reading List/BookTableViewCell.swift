//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Conner on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func toggleBookReadStatus(_ sender: Any) {
    }
    
    @IBOutlet var bookTitleText: UILabel!
    @IBOutlet var bookHasBeenRead: UIButton!
    
}
