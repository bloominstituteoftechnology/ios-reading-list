//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jeremy Taylor on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
     var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func toggleHasBeenRead(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    private func updateViews() {
        guard let book = book else { return }
        
        titleLabel.text = book.title
        
        if book.hasBeenRead {
            hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
           hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
}
