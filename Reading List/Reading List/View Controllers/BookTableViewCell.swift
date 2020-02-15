//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Elizabeth Thomas on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    weak var delegate: BookTableViewCellDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seenButtonLabel: UIButton!
    
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    

    var book: Book?
    
    func updateViews() {
        titleLabel.text = book?.title
        if book?.hasBeenRead == true {
            let checked = UIImage(named: "checked")
            seenButtonLabel.setImage(checked, for: .normal)
        } else {
            let unchecked = UIImage(named: "unchecked")
            seenButtonLabel.setImage(unchecked, for: .normal)        }
    }
    
}

// add book segue
// book detail segue
// title add new book
// save button
