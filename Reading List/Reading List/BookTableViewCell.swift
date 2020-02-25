//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Samuel Esserman on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func updateViews() {
        if let book = book {
            titleLabel.text = book.title
            switch book.hasBeenRead {
                case true:
                    readButton.setImage(UIImage(named: "checked"), for: .normal)
                case false:
                    readButton.setImage(UIImage(named: "unchecked"), for: .normal)
            }
        }
    }
    @IBAction func readButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
}
