//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dawn Jones on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readCheckBox: UIButton!
    
    @IBAction func checkReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    var book: Book? {
        didSet {
            self.updateViews()
        }
    }
    
    func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        readCheckBox.setImage(UIImage(named: "unchecked"), for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
