//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Donella Barcelo on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var delegate: BookTableViewDelegate?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    

    func updateViews() {
        let greenCellColor = UIColor(red: 0.749, green: 0.8784, blue: 0.102, alpha: 1.0)
        let redCellColor = UIColor(red: 1, green: 0.5686, blue: 0.5686, alpha: 1.0)
        
        guard let book = book else { return }
        titleLabel.text = book.title
        
        if book.hasBeenRead == true {
            guard let image = UIImage(named: "checked") else { return }
            hasBeenReadButton.setImage(image, for: .normal)
            self.backgroundColor = greenCellColor
        } else {
            guard let image = UIImage(named: "unchecked") else { return }
            hasBeenReadButton.setImage(image, for: .normal)
            self.backgroundColor = redCellColor
        }
    }

    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
