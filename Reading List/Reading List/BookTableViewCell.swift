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
        guard let bookTitle = bookTitleText.text,
            let bookHasBeenRead = bookHasBeenRead.currentImage else { return }
        
    }
    
    @IBAction func toggleBookReadStatus(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    @IBOutlet var bookTitleText: UILabel!
    @IBOutlet var bookHasBeenRead: UIButton!
    
    // MARK: - Properties
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: BookTableViewCellDelegate?
    
}
