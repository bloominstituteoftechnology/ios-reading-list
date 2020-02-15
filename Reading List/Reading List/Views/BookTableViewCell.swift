//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Matthew Martindale on 2/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadLabel: UIButton!
    
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
    }
    
}
