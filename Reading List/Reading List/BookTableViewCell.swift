//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Christopher Aronson on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var checkmarkButton: UIButton!
    
    var book: Book?
    var delegate: BookTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        
        guard let labelString = book?.title else { return }
        bookTitleLabel.text = labelString
        
        guard let shouldBeChecked = book?.hasBeenRead else { return }
        if shouldBeChecked {
            checkmarkButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkmarkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        
    }

    @IBAction func checkmarkButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
