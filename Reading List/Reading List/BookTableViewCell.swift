//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Cameron Dunn on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var button : UIButton!
    
    @IBAction func buttonTapped(){
        
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
