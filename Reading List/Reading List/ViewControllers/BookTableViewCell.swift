//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Clayton Watkins on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var readUnreadButton: UIButton!
    
    var book: Book?{
        didSet{
            updateViews()
        }
    }
    var delegate: BookTableViewCellDelegate?
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        if book.hasBeenRead == false{
            if let image = UIImage(named: "unchecked.png"){
                readUnreadButton.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "checked.png"){
                readUnreadButton.setImage(image, for: .normal)
            }
        }
    }
    
    @IBAction func readUnreadButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
