//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Isaac Lyons on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    var delegate: BookTableViewCellDelegate?
    
    private func updateViews() {
        guard let book = book else { return }
        nameLabel.text = book.title
        readButton.setImage(UIImage(named: "\(book.hasBeenRead ? "" : "un")checked"), for: .normal)
    }

    @IBAction func readButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
