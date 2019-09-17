//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jonalynn Masters on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
      var checkedImage = UIImage(named: "checked") //as UIImage?
      var uncheckedImage = UIImage(named: "unchecked") //as UIImage?
      weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    @IBAction func isReadButton(_ sender: UIButton) {
    }
    

}
