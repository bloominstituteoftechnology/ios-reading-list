//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Farhan on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookLabel: UILabel!

    @IBOutlet weak var checkbutton: UIButton!
    
    @IBAction func checkMark(_ sender: Any) {
        
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
