//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Nathanael Youngren on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    func updateViews() {
        if let book = book {
            bookLabel.text = book.title
            let read = book.hasBeenRead
            
            if read {
                let checked = UIImage(named: "checked")
                bookButton.setImage(checked, for: .selected)
            } else {
                let unchecked = UIImage(named: "unchecked")
                bookButton.setImage(unchecked, for: .normal)
            }
        }
    }
    
    @IBAction func bookButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: BookTableViewCellDelegate?
}
