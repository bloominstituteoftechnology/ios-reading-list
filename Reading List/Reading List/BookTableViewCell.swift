//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by John McCants on 6/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    

    @IBOutlet weak var bookLabel: UILabel!
    
    
    @IBOutlet weak var checkButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    
    
    var book : Book? {
        didSet {
            updateViews()
        }
        
    }
    
    func updateViews() {
        
        guard let book = book else {
            return
            
        }
        bookLabel.text = book.title

        if book.hasBeenRead == true {
            checkButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
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
