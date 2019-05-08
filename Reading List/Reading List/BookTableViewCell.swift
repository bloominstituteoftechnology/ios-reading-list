//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Kobe McKee on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    weak var delegate: BookTableViewCellDelegate?

    var book: Book? {
        didSet {
            updateViews()
        }
    }

    
    func updateViews() {
        guard let title = book?.title else { return }
        titleLabel.text = title
        guard let hasRead = book?.hasBeenRead else { return }
        if hasRead == true {
            readButton.setImage(UIImage(named: "checked.png"), for: .normal)
        } else {
            readButton.setImage(UIImage(named: "unchecked.png"), for: .normal)
        }
        
        
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    @IBAction func readButtonPressed(_ sender: Any) {
        print("Read button pressed")
        delegate?.toggleHasBeenRead(for: self)
        
    }
    
    
    
}
