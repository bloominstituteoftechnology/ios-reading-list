//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Hector Steven on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

	@IBOutlet weak var bookTitleLabel: UILabel!
	
	@IBAction func hasBeenReadButton(_ sender: Any) {
		print("pressed")
	}
	
}
