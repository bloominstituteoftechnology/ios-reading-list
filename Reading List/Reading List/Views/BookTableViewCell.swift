//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Shawn Gee on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var checkMarkButton: UIButton!
    
    
    // MARK: - Public Properties
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    // MARK: - IBActions
    
    @IBAction func checkMarkToggled(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
    }
    
    // MARK: - Private Methods
    
    private func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        updateCheckMark(checked: book.hasBeenRead)
    }
    
    private func updateCheckMark(checked: Bool) {
        let checkMarkImage = checked ? UIImage(named: "checked") : UIImage(named: "unchecked")
        checkMarkButton.setImage(checkMarkImage, for: .normal)
    }
}
