//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Michael Redig on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
	@IBOutlet var bookTitleLabel: UILabel!
	@IBOutlet var isReadCheckButton: UIButton!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)		
        // Configure the view for the selected state
    }
	@IBAction func isReadCheckButtonPressed(_ sender: UIButton) {
	}
	
}
