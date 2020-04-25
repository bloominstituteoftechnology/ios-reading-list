//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Josh Kocsis on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book?
    
    weak var delegate: BookTableViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: hasBeenReadButton)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateViews() {
        guard let book = self.book else { return }
        bookLabel.text = book.title
        hasBeenReadButton.setTitle(book.hasBeenRead ? "Read Books" : "Unread Books", for: .normal)
    }


}
