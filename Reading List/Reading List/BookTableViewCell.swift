//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jesse Ruiz on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    private func updateViews() {
        guard let book = book else { return }
        bookLabel.text = book.title
        let checkedImage = UIImage(named: "checked")
        let uncheckedImage = UIImage(named: "unchecked")
        if book.hasBeenRead == true {
            checkBoxButton.setImage(checkedImage, for: .normal)
        } else {
            checkBoxButton.setImage(uncheckedImage, for: .normal)
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    // MARK: - Actions
    @IBAction func checkBoxButtonAction(_ sender: UIButton) {
        
    }
}
