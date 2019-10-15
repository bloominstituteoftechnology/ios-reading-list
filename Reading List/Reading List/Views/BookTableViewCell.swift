//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by morse on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    var book: Book?
    
    @IBAction func readButtonTapped(_ sender: Any) {
    }
    

}
