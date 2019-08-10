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
    
    var book: Book? {
        didSet {
            
        }
    }
    
    
    @IBAction func statusButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: BookTableViewCell())
    }
    
    
    func updateViews() {
        guard let book = book else { return }
        bookNameLabel.text = book.title
        if book.hasBeenRead == true {
            if let checkedImage = UIImage(named: "checked") {
                readStatusButton.setImage(checkedImage, for: .normal)
            }
        } else if book.hasBeenRead == false {
            if let uncheckedImage = UIImage(named: "unchecked") {
                readStatusButton.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
}
