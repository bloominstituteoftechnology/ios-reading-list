//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by morse on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    var book: Book? {
        didSet {
            updateView()
        }
    }
    
    @IBAction func readButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateView() {
        guard let book = book else { return }
        
        titleLabel.text = book.title
        if book.hasBeenRead {
            readButton.setBackgroundImage(UIImage(named: "checked"), for: .normal)
        } else {
            readButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    

}
