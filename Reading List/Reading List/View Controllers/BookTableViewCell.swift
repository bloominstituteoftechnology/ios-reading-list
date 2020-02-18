//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Breena Greek on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    

    var book: Book?{
        didSet{
            updateViews()
        }
    }
    
    // MARK: IBOutlets
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var readToggle: UIButton!
    
    // MARK: IBActions
    
    @IBAction func readToggleButton(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    func updateViews() {
        if let book = book {
        bookLabel.text = book.title
        }
        
        if book?.hasBeenRead == true {
            readToggle.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            readToggle.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
}
