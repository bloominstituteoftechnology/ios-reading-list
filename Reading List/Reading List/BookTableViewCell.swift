//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dennis Rudolph on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var delegate: BookTableViewCellDelegate?
    
    var book: Book?
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonTapped(sender: UIButton!) {
        delegate?.toggleHasBeenRead(for: self)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitle.text = book.title
        
        let bookStatus = book.hasBeenRead
        if bookStatus {
            button.imageView?.image = UIImage(named: "checked")
        } else {
            button.imageView?.image = UIImage(named: "unchecked")
        }
    }
}
