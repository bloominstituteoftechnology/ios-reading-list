//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by John Holowesko on 12/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookButton: UIButton!
    
    var book: Book?
    var delegate: BookTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitle.text = book.title
        if book.hasBeenRead == true {
            bookButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            bookButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    // MARK: - IBActions
        @IBAction func bookButtonTapped(_ sender: UIButton) {
            delegate?.toggleHasBeenRead(for: self)
    }
}
