//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Conner on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    func updateViews() {
        if book.hasBeenRead {
            let image = UIImage(named: "checked.png") as UIImage?
            bookHasBeenRead.setImage(image, for: [])
        } else {
            let image = UIImage(named: "unchecked.png") as UIImage?
            bookHasBeenRead.setImage(image, for: [])
        }

        bookTitleText.text = book.title
    }

    @IBAction func toggleBookReadStatus(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }

    @IBOutlet var bookTitleText: UILabel!
    @IBOutlet var bookHasBeenRead: UIButton!

    // MARK: - Properties
    var book: Book! {
        didSet {
            updateViews()
        }
    }
    weak var delegate: BookTableViewCellDelegate?

}
