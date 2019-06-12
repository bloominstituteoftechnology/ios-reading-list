//
//  BooksTableViewCell.swift
//  Reading List
//
//  Created by Kat Milton on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    // MARK: - Properties and Outlets
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookHasBeenReadButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    
    // MARK: - Functions
    func updateViews() {
        guard let title = book?.title else { return }
        bookTitleLabel.text = title
        guard let readStatus = book?.hasBeenRead else { return }
        if readStatus == false {
            bookHasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        } else {
            bookHasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func readButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    

}
