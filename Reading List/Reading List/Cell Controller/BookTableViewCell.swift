//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Welinkton on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBAction func checkboxToggle(_ sender: Any) {
        
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
