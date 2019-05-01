//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by morse on 4/29/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookReadButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?

    var book: Book? {
        didSet {
            updateViews()
            
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
    
    @IBAction func bookReadButtonTapped(_ sender: Any) {
        
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        
        switch book.hasBeenRead {
        case true:
            bookReadButton.setImage(UIImage(named: "checked"), for: .normal)
        case false:
            bookReadButton.setImage(UIImage(named: "unchecked"), for: .selected)
        }
    }
}
