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
