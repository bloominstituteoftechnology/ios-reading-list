//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Ian Becker on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    var book: Book?
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var readButton: UIButton!
    @IBAction func isNotReadButton(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
        
    }
    func updateViews() {
        guard let book = book else { return }
        
        bookTitle.text = book.title
        readButton.setImage(UIImage(named: "unchecked"), for: .normal)
        readButton.setImage(UIImage(named: "checked"), for: .normal)
    }
}
