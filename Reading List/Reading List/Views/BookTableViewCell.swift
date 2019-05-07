//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jeremy Taylor on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    // MARK: - Properties
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var readStatusButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: BookTableViewCellDelegate?
    
    @IBAction func toggleReadStatus(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    private func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        
        
        var image: UIImage!
        
        if book.hasBeenRead {
            image = UIImage(named: "checked")
        } else {
            image = UIImage(named: "unchecked")
        }
       readStatusButton.setImage(image, for: .normal)
    }
}
