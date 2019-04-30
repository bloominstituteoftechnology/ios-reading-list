//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jonathan Ferrer on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBAction func checkButtonPressed(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var bookLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
}
