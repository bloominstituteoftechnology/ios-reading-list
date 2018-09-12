//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Welinkton on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
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
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    // have the button call the toggle delegate
    @IBAction func checkboxToggle(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    // Set the title of the label and incorporate the checked images. 
    func updateViews() {
        guard let book = book else {return}
        bookTitleLabel?.text = book.title
        
        book.hasBeenRead ? checkButton?.setImage(#imageLiteral(resourceName: "checked"), for: .normal) : checkButton?.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
    }
    
    // referring to the delegate protocol
    weak var delegate: BookTableViewCellDelegate?
    
    
    
}
