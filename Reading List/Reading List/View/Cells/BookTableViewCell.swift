//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Chad Rutherford on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    weak var delegate: BookTableViewCellDelegate?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Actions
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Cell Configuration
    func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.name
        let bookImage = book.hasBeenRead ?  "checked" : "unchecked"
        checkMarkButton.setImage(UIImage(named: bookImage), for: .normal)
    }
}
