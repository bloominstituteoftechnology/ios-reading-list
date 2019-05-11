//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Seschwan on 5/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var readBtn:        UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    var bookTableCellDelegate: BookTableViewCellDelegate?
    
    
    func updateViews() {
        guard let title = book?.title else { return }
        bookTitleLabel.text = title
        guard let hasRead = book?.hasBeenRead else { return }
        if hasRead == true {
            readBtn.setImage(UIImage(named: "checked.png"), for: .normal)
        } else {
            readBtn.setImage(UIImage(named: "unchecked.png"), for: .normal)
        }
    }
    
    // Read Button Action
    @IBAction func readBtnPressed(_ sender: UIButton) {
        self.bookTableCellDelegate?.toggleHasBeenRead(for: self)
        print("Button was Pressed")
    }
    
}
