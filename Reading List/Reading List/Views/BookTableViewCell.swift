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
    
    var book: Book?
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        toggleHasBeenRead(for: <#T##BookTableViewCell#>)
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        bookTitleLabel.text = book.title
        
        if book.hasBeenRead {
            hasBeenReadButton.imageView?.image = UIImage(named: "checked")
        } else {
            hasBeenReadButton.imageView?.image = UIImage(named: "unchecked")
        }
    }
    
}

extension BookTableViewCell: BookTableViewCellDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        
    }
    
}
