//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Christy Hicks on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var readCheckBoxButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func readCheckBoxButtonTapped(_ sender: UIButton) {
    }
}
