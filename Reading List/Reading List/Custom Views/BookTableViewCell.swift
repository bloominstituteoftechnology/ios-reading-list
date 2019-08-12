//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Eoin Lavery on 11/08/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var delegate: BookTableViewDelegate?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        if book.hasBeenRead == true {
            guard let image = UIImage(named: "checked") else { return }
            hasBeenReadButton.setImage(image, for: .normal)
        } else {
            guard let image = UIImage(named: "unchecked") else { return }
            hasBeenReadButton.setImage(image, for: .normal)
        }
    }
    
    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
