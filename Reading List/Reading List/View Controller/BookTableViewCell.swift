//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by De MicheliStefano on 31.07.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    private func updateViews() {
        guard let book = book else { return }
        // Set the cell's label to the book's title
        bookTitleTextLabel.text = book.title
        
        // Set image based on whether book hasBeenRead
        book.hasBeenRead == true
            ? hasBeenReadButtonLabel.setImage(UIImage(named: "checked"), for: .normal)
            : hasBeenReadButtonLabel.setImage(UIImage(named: "unchecked"), for: .normal)
    }
    
    // MARK: - Methods
    
    @IBAction func selectHasBeenRead(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    // MARK: - Properties
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookTitleTextLabel: UILabel!
    @IBOutlet weak var hasBeenReadButtonLabel: UIButton!
    
}
