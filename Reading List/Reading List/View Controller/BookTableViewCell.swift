//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Michael on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    
    
    var delegate: BookTableViewCellDelegate?
    
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    


    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        bookTitleLabel.text = book?.title
        if book?.hasBeenRead == true {
            hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    
    
    
    

}

