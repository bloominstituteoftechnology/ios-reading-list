//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Moin Uddin on 9/4/18.
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
    
    
    
    @IBAction func toggleRead(_ sender: Any) {
    }
    
    
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    

}
