//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Taylor Lyles on 5/7/19.
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
	
	@IBOutlet weak var title: UILabel!

	@IBOutlet weak var button: UIButton!
	
	@IBAction func actionButton(_ sender: Any) {
	}
	
	
}
