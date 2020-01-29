//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Nichole Davidson on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var checkedButton: UIButton!
    @IBAction func checkedButtonTapped(_ sender: UIButton) {
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
