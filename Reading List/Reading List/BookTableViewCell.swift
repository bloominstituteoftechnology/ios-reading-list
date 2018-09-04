//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dillon McElhinney on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    @IBAction func toggleHasBeenRead(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    // MARK: - Private Utility Methods
    private func updateViews() {
        //Make sure there is a book
        guard let book = book else { return }
        
        //Set the book's title and whether it has been read or not
        titleLabel.text = book.title
        if book.hasBeenRead {
            hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
}
