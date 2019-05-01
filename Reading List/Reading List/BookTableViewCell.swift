//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jonathan Ferrer on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var delegate: BookTableViewCellDelegate?
    
    var book: Book?
    
    // sets the title of the book to label and the appropriate image if its been read
    func updateViews(book:Book){
         bookLabel.text = book.title
        
        if book.hasBeenRead == true{
            checkButton.setImage(UIImage(named: "checked"), for: .normal)
        } else{
            checkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    
    @IBAction func checkButtonPressed(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: )
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var bookLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    
}
