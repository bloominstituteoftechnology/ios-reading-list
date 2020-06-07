//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Cora Jacobson on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    @IBAction func hasBeenReadButton(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        if let book = book {
            titleLabel.text = book.title
            if book.hasBeenRead == false {
                hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
            } else {
                hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
            }
        }
    }

}
