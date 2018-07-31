//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Linh Bouniol on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet var bookLabel: UILabel!
    @IBOutlet var checkboxButtonLabel: UIButton!
    
    @IBAction func checkboxButton(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        bookLabel.text = book.title
        
        // If book is read, button's title is checked.
        // If book is not read, button's title is unchecked.
        if book.hasBeenRead == true {
            checkboxButtonLabel.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkboxButtonLabel.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    
}
