//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Wyatt Harrell on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func hasBeenReadButonTapped(_ sender: Any) {
    }
    

}
