//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Shawn James on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    // MARK: - Properties
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    var delegate: BookTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Actions
    @IBAction func hasBeenReadButtonPressed(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        bookTitleLabel.text = self.book?.title
        if self.book?.hasBeenRead == true { hasBeenReadButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal) }
        else { hasBeenReadButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal) }
    }
    
}
