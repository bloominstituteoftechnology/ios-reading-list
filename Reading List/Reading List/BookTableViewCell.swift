//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Harm on 3/17/23.
//  Copyright © 2023 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBAction func readTapped(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
