//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jeffrey Carpenter on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}

class BookTableViewCell: UITableViewCell {
    
    weak var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var isReadButton: UIButton!
    
    @IBAction func readButtonPressed(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        
        guard let book = book else { return }
        
        bookTitleLabel.text = book.title
        if book.hasBeenRead {
            isReadButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            isReadButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
    }
}
