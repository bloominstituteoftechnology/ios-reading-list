//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Stuart on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}

class BookTableViewCell: UITableViewCell {
    
    private func updateViews() {
        guard let book = book else { return }
        
        bookTitleLabel.text = book.title
        hasBeenReadButton.setImage(book.hasBeenRead ? #imageLiteral(resourceName: "checked.png") : #imageLiteral(resourceName: "unchecked.png"), for: .normal)
    }
    
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    var book: Book? { didSet { updateViews() }}
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
}
