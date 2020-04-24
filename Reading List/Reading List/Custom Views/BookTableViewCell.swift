//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dillon P on 8/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var readStatusButton: UIButton!
    
    var delegate: BookTableViewCellDelegate?
    var index: IndexPath?
    let bookController = BookController()
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBAction func statusButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    
    func updateViews() {
        guard let book = book else { return }
        bookNameLabel.text = book.title
        if book.hasBeenRead == true {
            let checkedImage = UIImage(named: "checked")
            readStatusButton.setImage(checkedImage, for: .normal)
            
        } else if book.hasBeenRead == false {
            let uncheckedImage = UIImage(named: "unchecked")
            readStatusButton.setImage(uncheckedImage, for: .normal)
            
        }
    }
    
}
