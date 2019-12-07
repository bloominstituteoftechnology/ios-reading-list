//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dennis Rudolph on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonTapped(sender: UIButton!) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitle.text = book.title
        
        let bookStatus = book.hasBeenRead
        if bookStatus {
            button.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            button.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
}
