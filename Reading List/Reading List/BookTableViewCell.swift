//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Aaron Cleveland on 12/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hasBeenSeen: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateviews()
        }
    }
    
    @IBAction func hasBeenReadButton(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    
    func updateviews() {
        self.nameLabel.text = book?.title
        if book?.hasBeenRead ?? true {
            hasBeenSeen.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasBeenSeen.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
}
