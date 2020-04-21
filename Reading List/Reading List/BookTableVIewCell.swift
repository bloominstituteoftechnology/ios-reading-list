//
//  BookTableVIewCell.swift
//  Reading List
//
//  Created by Vincent Hoang on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var hasReadButton: UIButton!
    
    var delegate: BookTableViewCellDelegate?
    
    @IBAction func checkboxPressed(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    var book: Book? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        guard let unwrappedBook = book else {
            fatalError("Book object in BookTableViewCell was null")
        }
        
        titleLabel?.text = unwrappedBook.title
        
        switch unwrappedBook.hasBeenRead {
        case true:
            hasReadButton?.setImage(UIImage(named: "checked"), for: .selected)
        case false:
            hasReadButton?.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
}
