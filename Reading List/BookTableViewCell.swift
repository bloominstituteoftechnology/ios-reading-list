//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Osha Washington on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: BookTableViewCellDelegate?

    //MARK: - IBOutlets
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var readCheckedBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - IBAction
    @IBAction func readCheckedBox(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    // MARK: - UpdateViews Func
    private func updateViews() {
            guard let book = book else { return }
            bookTitle.text = book.title
            if book.hasBeenRead {
                let image = UIImage(named: "checked")
                readCheckedBox.setImage(image, for: .normal)
            } else {
                let image = UIImage(named: "unchecked")
                readCheckedBox.setImage(image, for: .normal)
            }
        }
    }
