//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Gerardo Hernandez on 12/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bookLabel: UILabel!
 
    @IBOutlet weak var readStatusButton: UIButton!
    
    var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    
    private func updateViews() {
        guard let book = book else  { return }
        bookLabel.text = book.title
        
        if book.hasBeenRead != true {
            guard let uncheckedImage = UIImage(named: "unchecked") else { return }
            readStatusButton.setImage(uncheckedImage, for: .normal)
                
        } else {
            guard let checkedImage = UIImage(named: "checked") else { return }
            readStatusButton.setImage(checkedImage, for: .normal)
        }
    }
    
    @IBAction func readStatusToggle(_ sender: UIButton) {
        delegate?.toogleHasBeenRead(for: self)
    }
    

}
