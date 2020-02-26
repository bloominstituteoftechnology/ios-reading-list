//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Mark Gerrior on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var labelTextField: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    @IBAction func hasBeenReadButton(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        if book.title.count == 0 {
            labelTextField.text = "<blank>"
        } else {
            labelTextField.text = book.title
        }
        
        var imageName = "unchecked.png"
        
        if book.hasBeenRead == true {
            imageName = "checked.png"
        }

        if let image = UIImage(named: imageName) {
            readButton.setImage(image, for: .normal)
        }
    }
}
