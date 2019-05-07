//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Ryan Murphy on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell:BookTableViewCell)
}

class BookTableViewCell: UITableViewCell {

    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    
        func updateViews(){
            bookTitleLabel.text = book?.title
            if book?.hasBeenRead == true{
                hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
            } else{
                hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
            }
    }
    
    @IBAction func hasBeenReadButtonPressed(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
}

