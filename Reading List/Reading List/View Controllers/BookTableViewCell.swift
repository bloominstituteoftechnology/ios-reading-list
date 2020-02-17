//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Rob Vance on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var readOrNotRead: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func readOrNotReadButtonTapped(_ sender: Any) {
        
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
    }
    
    weak var delegate: BookTableViewCellDelegate?
    

    
    func updateViews() {
        if let book = book {
            bookNameLabel.text = book.title
        }
        if book?.hasBeenRead == false {
            readOrNotRead.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            readOrNotRead.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
