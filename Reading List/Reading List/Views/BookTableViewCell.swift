//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Matthew Martindale on 2/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadLabel: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: BookTableViewCellDelegate?

    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        let checkedImage: UIImage = book.hasBeenRead ? UIImage(named: "checked")! : UIImage(named: "unchecked")!
        hasBeenReadLabel.setImage(checkedImage, for: .normal)
    }
    
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
}
