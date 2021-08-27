//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Gerardo Hernandez on 8/27/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book? {
        didSet {
            UpdateViews()
        }
    }
    
     var delegate: BookTableViewCellDelegate?
    
    
    // View Helper Method
    private func UpdateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        
        if book.hasBeenRead == false {
            hasBeenReadButton.isSelected = false
        } else {
            hasBeenReadButton.isSelected = true
        }
    }
    
    // MARK - Actions
    @IBAction func hasBeenReadTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    

}
