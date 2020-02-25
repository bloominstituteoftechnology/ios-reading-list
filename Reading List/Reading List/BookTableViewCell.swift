//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Wyatt Harrell on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?

    @IBAction func hasBeenReadButonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        bookTitleLabel.text = book.title
        if book.hasBeenRead {
            hasBeenReadButton.setImage(UIImage(named: "checked"), for: .selected)
        } else {
            hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

}
