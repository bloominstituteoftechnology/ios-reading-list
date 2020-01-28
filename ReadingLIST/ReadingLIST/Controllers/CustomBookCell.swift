//
//  CustomBookCell.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class CustomBookCell: UITableViewCell {

    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

    @IBAction func statusTapped(_ sender: UIButton) {
        
    }
    
    
}
