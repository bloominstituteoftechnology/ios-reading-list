//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Norlan Tibanear on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var checkButton: UIButton!
    
    
    weak var delegate: BookTableViewCellDelegate?
    
    
    var book: Book? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let book = book else { return }
        titleLabel.text = book.title
        
        if book.hasBeenRead == true {
            checkButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        
    } // END
    
    
    
    
    @IBAction func checkBtn_TouchUpInside(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
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
