//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jordan Davis on 5/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBAction func checkUncheckedButtonPressed(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        bookTitleLabel.text = book.title
        if book.hasBeenRead == true {
            checkUncheckedButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkUncheckedButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    //MARK: -Properties
    var book: Book?
    
    var delegate: BookTableViewCellDelegate?
    
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var checkUncheckedButton: UIButton!
}
