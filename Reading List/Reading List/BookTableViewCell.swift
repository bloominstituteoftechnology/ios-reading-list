//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Mitchell Budge on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let bookTitle = book?.title else { return }
        bookLabel.text = bookTitle
        if book?.hasBeenRead == true {
            readStatusButton.setImage(UIImage(named: "checked"), for: .normal)
        }   else {
            readStatusButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var readStatusButton: UIButton!
    @IBAction func readStatusButtonPressed(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    var book: Book?
    var delegate: BookTableViewCellDelegate?
    
}
