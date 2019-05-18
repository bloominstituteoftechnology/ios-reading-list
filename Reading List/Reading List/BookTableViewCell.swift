//
//  UITableViewCell.swift
//  Reading List
//
//  Created by patelpra on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var bookLabel: UILabel!
   
    @IBOutlet weak var checkViewBox: UIButton!
    
    @IBAction func CheckViewBox(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    private func updateViews() {
        guard let book = self.book else { return }
        self.bookLabel.text = book.title
        
        if book.hasBeenRead == true {
            let checked = UIImage(named: "checked")
            self.checkViewBox.setImage(checked, for: .normal)
        } else {
            let unchecked = UIImage(named: "unchecked")
            self.checkViewBox.setImage(unchecked, for: .normal)
        }
    }
}


    
