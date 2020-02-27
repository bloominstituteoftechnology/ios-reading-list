//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Michael on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    
    
    weak var delegate: BookTableViewCellDelegate?
    
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    


    @IBAction func hasBeenReadTapped(_ sender: Any) {
//        delegate?.toggleHasBeenRead(for: self)
        guard let book = book else { return }
        NotificationCenter.default.post(name: .toggleBeenRead, object: self, userInfo: ["book" : book])
    }
    
    func updateViews() {
        if let book = book {
            bookTitleLabel.text = book.title
        }
        if book?.hasBeenRead == true {
            hasBeenReadButton.setImage(UIImage(imageLiteralResourceName: "checked"), for: .normal)
        } else {
            hasBeenReadButton.setImage(UIImage(imageLiteralResourceName: "unchecked"), for: .normal)
        }
    }
}

