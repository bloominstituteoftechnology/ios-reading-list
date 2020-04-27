//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Bronson Mullens on 4/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    
    weak var delegate: BookTableViewCellDelegate?
    
    // IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasReadButton: UIButton!
    
    // IBActions
    @IBAction func hasReadButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateViews() {
        if book?.hasBeenRead == true {
            let image = UIImage(named: "checked.png")
            hasReadButton.setImage(image, for: .normal)
        } else if book?.hasBeenRead == false {
            let image = UIImage(named: "unchecked.png")
            hasReadButton.setImage(image, for: .normal)
        }
    }
    
}
