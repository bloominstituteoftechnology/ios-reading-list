//
//  ReadingListTableViewCell.swift
//  Reading List
//
//  Created by Jake Connerly on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewCell: UITableViewCell {
    
    //
    // MARK: - Outlets and Properties
    //
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var readUnreadButton: UIButton!
    
    var book: Book?
    weak var delegate: ReadingListTableViewCellDelegate?
    
    //
    // MARK: - Actions
    //

    @IBAction func readUnreadButtonTapped(_ sender: UIButton) {
        self.delegate?.toggleHasBeenRead(for: self)
    }
    
    //
    // MARK: - Methods
    //
    
    func updateViews() {
        bookTitleLabel.text = book?.title
        if book?.hasBeenRead == true {
            readUnreadButton.imageView?.image = UIImage(named: "checked")
        } else {
            readUnreadButton.imageView?.image = UIImage(named: "unchecked")
        }
    }

}
