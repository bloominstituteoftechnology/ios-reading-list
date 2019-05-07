//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Mitchell Budge on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
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
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var readStatusButton: UIButton!
    @IBAction func readStatusButtonPressed(_ sender: Any) {
    }
    
    
}
