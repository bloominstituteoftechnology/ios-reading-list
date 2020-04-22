//
//  ReadingListTableViewCell.swift
//  Reading List
//
//  Created by Brian Rouse on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var readUnreadButton: UIButton!
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: ReadingListTableViewCellDelegate?
    
    
    @IBAction func readUnreadButtonTapped(_ sender: UIButton) {
        self.delegate?.toggleHasBeenRead(for: self)
    }
    
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        
        if book.hasBeenRead == true {
            readUnreadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            readUnreadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
}

