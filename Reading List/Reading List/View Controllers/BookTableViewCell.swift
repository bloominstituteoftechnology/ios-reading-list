//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Chad Parker on 2/16/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var isReadButton: UIButton!

    var book: Book? {
        didSet {
            updateViews()
        }
    }
    var delegate: BookTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        if book.hasBeenRead {
            isReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            isReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

    @IBAction func isReadButtonWasTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
