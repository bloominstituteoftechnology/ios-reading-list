//
//  ReadingListTableViewCell.swift
//  Reading List
//
//  Created by Lisa Sampson on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenReadButton(for cell: ReadingListTableViewCell)
}

class ReadingListTableViewCell: UITableViewCell {
    
    // MARK: - Properties and Outlets
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    // MARK: - Delegate Methods
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenReadButton(for: self)
    }
    
    // MARK: - View Loading Methods
    func updateViews() {
        guard let book = book else { return }
        bookLabel.text = book.title
        let image = book.hasBeenRead ? UIImage(named: "checked") : UIImage(named: "unchecked")
        isCompleteButton.setImage(image, for: .normal)
    }
    
}
