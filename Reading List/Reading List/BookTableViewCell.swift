//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Moses Robinson on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBAction func hasReadChecked(_ sender: Any) {
        
    }
    
    //MARK: - Properties
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var hasReadButton: UIButton!
}
