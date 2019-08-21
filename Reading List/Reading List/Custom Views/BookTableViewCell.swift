//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Ciara Beitel on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    var delegate: BookTableViewCellDelegate?
    var book: Book?
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    @IBAction func readOrNotTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        if book.hasBeenRead {
            hasBeenReadButton.setImage(UIImage(named: "checked.png"), for: .normal)
        } else {
            hasBeenReadButton.setImage(UIImage(named: "unchecked.png"), for: .normal)
        }
    }
}
