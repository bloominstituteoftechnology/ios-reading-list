//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Daniela Parra on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    func updateViews() {
        guard let book = book else { return}
        
        bookLabel.text = book.title
        
        if book.hasBeenRead {
            hasbeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasbeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    //After hasBeenRead button is clicked...
    @IBAction func updateButton(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    //Outlets to cell label and button.
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var hasbeenReadButton: UIButton!
    
}
