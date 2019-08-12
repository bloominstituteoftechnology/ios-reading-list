//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jessie Ann Griffin on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookReadCheckBox: UIButton!
    
    @IBAction func hasBeenReadPressed(_ sender: UIButton) {
        
        delegate?.toggleHasBeenRead(for: cell)
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        bookTitleLabel.text = book.title
        
        if !book.hasBeenRead {
            bookReadCheckBox.setImage(UIImage(named: "unchecked"), for: .normal)
        } else {
            bookReadCheckBox.setImage(UIImage(named: "checked"), for: .normal)
        }
    }
}
