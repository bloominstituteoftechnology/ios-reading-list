//
//  BookTableViewCell.swift
//  Reading List again
//
//  Created by Nathanael Youngren on 1/17/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}

class BookTableViewCell: UITableViewCell {
    
    var book: Book? {
        didSet { updateViews() }
    }
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var unCheckButton: UIButton!
    
    @IBAction func unCheckButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    private func updateViews() {
        if let book = book {
            bookTitleLabel.text = book.title
            
            let imageName = book.hasBeenRead ? "checked" : "unchecked"
            guard let image = UIImage(named: imageName) else { return }
            unCheckButton.setImage(image, for: .normal)
        }
    }
}
