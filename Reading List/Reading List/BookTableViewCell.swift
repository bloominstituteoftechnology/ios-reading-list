//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by David Williams on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var seenButtton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
   
    weak var delegate: BookTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        if book.hasBeenRead {
            seenButtton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            seenButtton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

    @IBAction func seenNotSeenTapped(_ sender: Any) {
        delegate?.toggleHasBeenread(for: self)
        updateViews()
    }
}
