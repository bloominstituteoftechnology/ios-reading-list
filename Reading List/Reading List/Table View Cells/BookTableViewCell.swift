//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Bobby Keffury on 8/10/19.
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
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBAction func bookButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { print ("no book")
            return }
        bookTitleLabel.text = book.title
        if book.hasBeenRead {
            let image = UIImage(named: "checked")
            bookButton.setImage(image!, for: .normal)
        } else {
            let image = UIImage(named: "unchecked")
            bookButton.setImage(image!, for: .normal)
        }
    }

}
