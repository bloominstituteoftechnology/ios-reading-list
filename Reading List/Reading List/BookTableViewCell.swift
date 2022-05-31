//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Waseem Idelbi on 5/23/22.
//  Copyright © 2022 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
//MARK: - Properties
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    var delegate: BookTableViewCellDelegate?
    let checkedImage   = UIImage(named: "checked")
    let uncheckedImage = UIImage(named: "unchecked")

//MARK: - IBOutlets
    @IBOutlet weak var BookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    @IBOutlet weak var bookImageView: UIImageView!
    
//MARK: - Methods
    func updateViews() {
        guard let book = book else { return }
        let readStatusImage = (book.hasBeenRead ? checkedImage : uncheckedImage)
        BookTitleLabel.text = book.title
        hasBeenReadButton.setTitle("", for: .normal)
        hasBeenReadButton.setImage(readStatusImage, for: .normal)
        bookImageView.image = book.image?.getImage()
    }
    
//MARK: - IBActions
    @IBAction func hasBeenReadButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }

}
