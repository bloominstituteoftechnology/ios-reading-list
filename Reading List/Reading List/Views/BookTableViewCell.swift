//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by John Kouris on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        bookTitleLabel.text = book.title
        
        if book.hasBeenRead {
            hasBeenReadButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            hasBeenReadButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
    }
    
}

extension BookTableViewCell: BookTableViewCellDelegate {

    func toggleHasBeenRead(for cell: BookTableViewCell) {
        cell.book?.hasBeenRead = !cell.book!.hasBeenRead
        updateViews()
    }

}
