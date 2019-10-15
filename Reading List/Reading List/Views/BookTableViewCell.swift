//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jon Bash on 2019-10-15.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    
    var delegate: BookTableViewDelegate?
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookReadButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let book = book else {
            print(BooksError.noBookInTableCell)
            return
        }
        
        let boxImage: String
        if book.haveRead {
            boxImage = "checked"
        } else {
            boxImage = "unchecked"
        }
        
        bookTitleLabel.text = book.title
        bookReadButton.setImage(UIImage(named: boxImage), for: .normal)
    }

    @IBAction func bookReadButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
