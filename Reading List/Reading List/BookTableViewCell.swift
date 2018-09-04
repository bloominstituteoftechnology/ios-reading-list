//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dillon McElhinney on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var titleLabel: UIView!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    @IBAction func toggleHasBeenRead(_ sender: UIButton) {
        
    }
    
}
