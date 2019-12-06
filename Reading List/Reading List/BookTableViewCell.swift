//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by David Williams on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    var book: Book?
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func seenNotSeenTapped(_ sender: UIButton) {
        Book.shared.hasBeenRead = !Book.shared.hasBeenRead
    }
    
    func upDateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        let seenButton = UIButton()
        if  Book.shared.hasBeenRead {
            seenButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
           seenButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
    }
}
