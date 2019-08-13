//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Vici Shaweddy on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        titleLabel.text = book.name
        if book.hasBeenRead == true {
            let image = UIImage(named: "checked")
            statusButton.setImage(image, for: .normal)
        } else if book.hasBeenRead == false {
            let image = UIImage(named: "unchecked")
            statusButton.setImage(image, for: .normal)
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
    
    @IBAction func statusPressed(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
}
