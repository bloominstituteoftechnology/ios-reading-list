//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Harmony Radley on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenReadFor(cell: self)
    }
    
    func updateViews() {
        if let book = book {
            titleLabel.text = book.title
            switch book.hasBeenRead {
            case true:
                hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
            case false:
               hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
            }
        }
        
    }
}
