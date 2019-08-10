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
    
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        
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
