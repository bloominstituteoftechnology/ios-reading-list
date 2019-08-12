//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Casualty on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import Foundation

protocol ReadingListDelegate {
    func toggleHasBeenRead(for cell: ReadingListTableViewCell)
}

class ReadingListTableViewCell: UITableViewCell {
    

    @IBOutlet weak var bookTitleLabel: UILabel!

    
    @IBOutlet weak var readButton: UIButton!
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    var delegate: ReadingListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func readButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        readButton.setImage(book.hasBeenRead ? UIImage(named: "checked") : UIImage(named: "unchecked"), for: .normal)
    }
}
