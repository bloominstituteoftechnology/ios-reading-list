//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by David Williams on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    

    var book: Book? {
        didSet {
            upDateViews()
        }
    }
       
var delegate: BookTableViewCellDelegate?
    
//    func toggleHasBeenRead(for cell: BookTableViewCell) {
//      guard let index = books.firstIndex(of: book) else { return }
//             books[index].toggleHasBeenRead()
//             saveToPersistentStore()
//    }
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var seenButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func seenNotSeenTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
        upDateViews()
    }

    func upDateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        if  book.hasBeenRead {
            seenButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            seenButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
}
