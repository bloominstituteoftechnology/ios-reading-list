//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Daniela Parra on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
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
    
    //After hasBeenRead button is clicked...
    @IBAction func updateButton(_ sender: Any) {
    }
    
    //Outlets to cell label and button.
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var hasbeenReadButton: UIButton!
    
}
