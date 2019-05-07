//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Thomas Cacciatore on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
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
    
    
    @IBAction func cellButtonTapped(_ sender: Any) {
        
        
        
    }
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    

}
