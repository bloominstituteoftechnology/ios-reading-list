//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_59 on 1/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var checkboxButtonLabel: UIButton!
    
    @IBAction func checkboxButton(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        bookLabel.text = book.title
        
        if book.hasBeenRead == true {
            checkboxButtonLabel.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkboxButtonLabel.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

}
