//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Joseph Rogers on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit



class BookTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var checkListButton: UIButton!
  
    weak var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet{
            updateViews()
        }
    }
    
    @IBAction func checkListPressed(_ sender: UIButton) {
       delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else {return}
        bookNameLabel.text = book.title
        let image = book.hasBeenRead ? UIImage(named: "checked") : UIImage(named: "unchecked")
        checkListButton.setImage(image, for: .normal)
    }
    
  
    
    
}
