//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Michael on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    

    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book?
    
    weak var delegate: BookTableViewCellDelegate?


    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: BookTableViewCell.)
    }
    
    func updateViews() {
        bookTitleLabel.text = book?.title
        hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
    }
    
    
    
    
    

}

extension BookTableViewCell: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if book?.hasBeenRead == true {
            hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    
}
