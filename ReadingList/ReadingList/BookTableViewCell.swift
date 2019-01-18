//
//  BookTableViewCell.swift
//  ReadingList
//
//  Created by Jocelyn Stuart on 1/17/19.
//  Copyright © 2019 JS. All rights reserved.
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
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var checkBox: UIButton!
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        titleLabel.text = book.title
        
        let checkButton = book.hasBeenRead ? UIImage(named: "checkedbox") : UIImage(named: "uncheckedbox")
        checkBox.setImage(checkButton, for: .normal)
        
    }

}
