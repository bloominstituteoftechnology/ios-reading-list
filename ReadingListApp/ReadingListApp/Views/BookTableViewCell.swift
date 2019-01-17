//
//  BookTableViewCell.swift
//  ReadingListApp
//
//  Created by Nelson Gonzalez on 1/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasReadButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let book = book else {return}
        
        bookTitleLabel.text = book.title
       
        let imageName = book.hasBeenRead ? "checked": "unchecked"
        let image = UIImage(named: imageName)
        hasReadButton.setImage(image, for: .normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func hasReadButtonPressed(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
}
