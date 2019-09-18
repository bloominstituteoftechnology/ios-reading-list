//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Gi Pyo Kim on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let book = book else { return }
    
        titleLabel.text = book.title
        switch book.hasBeenRead {
        case true:
            checkBoxButton.setImage(UIImage(named: "checked"), for: .normal)
        case false:
            checkBoxButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

    @IBAction func checkBoxToggle(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
