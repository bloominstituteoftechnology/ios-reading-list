//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dawn Jones on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readCheckBox: UIButton!
    
    @IBAction func checkReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        if book.hasBeenRead {
            readCheckBox.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            readCheckBox.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

}
