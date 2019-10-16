//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_204 on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: BookTableViewCellDelegate?
    
    private func updateViews() {
        guard let book = book else { return }
        
        bookTitleLabel.text = book.title
        if (book.hasBeenRead) {
            let image = UIImage(named: "checked")
            checkButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(named: "unchecked")
            checkButton.setImage(image, for: .normal)
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
