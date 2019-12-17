//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Tobi Kuyoro on 17/12/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var delegate: BookTableViewDelegate?
    
    var book: Book? {
        didSet {
            updateviews()
        }
    }
    
    func updateviews() {
        if let book = book {
            bookTitle.text = book.title
            hasBeenReadButton.imageView?.image = UIImage(named: "checked")
        }
    }
    
    
    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
}
