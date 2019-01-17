//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Moses Robinson on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBAction func hasReadChecked(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    private func updateViews() {
        guard let book = book else { return }
        
        bookNameLabel.text = book.title
        if book.hasBeenRead == true {
            hasReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    //MARK: - Properties
    
    var book: Book?
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var hasReadButton: UIButton!
}
