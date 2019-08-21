//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jordan Christensen on 8/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        bookNameLabel.text = book.title
        if (book.hasBeenRead) {
            checkButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func toggleRead(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
