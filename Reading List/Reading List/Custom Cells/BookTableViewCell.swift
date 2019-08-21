//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Percy Ngan on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {


	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var buttonLabel: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()

    }


	@IBAction func buttonPressed(_ sender: UIButton) {
	}
	

	override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
