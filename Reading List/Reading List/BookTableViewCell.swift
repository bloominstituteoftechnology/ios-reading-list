//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by admin on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book?
    
    var delegate: BookTableViewCellDelegate?
    
    private func updateViews() {
        guard let book = book else { return }
        
        titleLabel.text = book.title
        if book.hasBeenRead == true {
            hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .selected)
        }
    }
}
