//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Joshua Rutkowski on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
//MARK: - IBOutlets
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: BookTableViewCellDelegate?
    
    /// Sets the book title label and whether the button is checked or unchecked
    private func updateViews() {
         guard let book = book else { return }

         bookLabel.text = book.title
         if (book.hasBeenRead) {
             let image = UIImage(named: "checked")
             checkButton.setImage(image, for: .normal)
         } else {
             let image = UIImage(named: "unchecked")
             checkButton.setImage(image, for: .normal)
         }
     }
    
    
//MARK: - IBActions
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
}
