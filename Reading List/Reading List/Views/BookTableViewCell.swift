//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Matthew Martindale on 2/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadLabel: UIButton!
    
    var book: Book?
    weak var delegate: BookTableViewCellDelegate?
    
    func updateViews() {
        bookTitleLabel.text = book?.title
        if book?.hasBeenRead == true {
            hasBeenReadLabel.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasBeenReadLabel.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        let bookTableViewCell = self
        delegate?.toggleHasBeenRead(for: bookTableViewCell)
    }
    
}
