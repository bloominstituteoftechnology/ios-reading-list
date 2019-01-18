//
//  BookTableViewCell.swift
//  ReadTheList Project
//
//  Created by Michael Flowers on 1/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit



class BookTableViewCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: BookTableViewCellDelegate?

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var checkMarkProperties: UIButton!
    
    
    
    @IBAction func changeCheckMark(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews(){
        guard let passedInBook = book else { return }
        bookTitleLabel.text = passedInBook.title
        checkMarkProperties.imageView?.image = passedInBook.hasBeenRead ? UIImage(named: "checked") : UIImage(named: "unchecked")
    }
}
