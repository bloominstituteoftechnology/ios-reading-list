//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Victor  on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var isReadButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    var book: Book?
    
    func updateViews() {
        guard let book = book else {return}
        bookLabel.text = book.title
        if book.hasBeenRead {
            isReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            isReadButton.setImage(UIImage(named: "Unchecked"), for: .normal)
        }
    }
    
    
    @IBAction func isReadButtonPressed(_ sender: Any) {
        //handle when button is pressed
        delegate?.toggleHasBeenRead(for: self)
    }
    
    
}
