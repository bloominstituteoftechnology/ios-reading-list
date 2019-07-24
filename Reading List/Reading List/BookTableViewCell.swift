//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Blake Andrew Price on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let book = book else { return }
        
        titleLabel.text = book.title
        
        if book.hasBeenRead == false {
            button.imageView?.image = #imageLiteral(resourceName: "unchecked")
        } else {
            button.imageView?.image = #imageLiteral(resourceName: "checked")
        }
    }
}


