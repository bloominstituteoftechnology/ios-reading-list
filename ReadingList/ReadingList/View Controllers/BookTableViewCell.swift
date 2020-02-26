//
//  ReadingListTableViewCell.swift
//  ReadingList
//
//  Created by Lambda_School_Loaner_259 on 2/25/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var hasBeenReadButton: UIButton!
    
    
    // MARK: - IBActions
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
    }
    
    // MARK: - Properties
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    let checkedImage = UIImage(named: "checked")!
    let uncheckedImage = UIImage(named: "unchecked")!
    var delegate: BookTableViewCellDelegate?
    
    func updateViews() {
        guard let book = book, !book.title.isEmpty else { return }
        titleLabel.text = book.title
        let image = book.hasBeenRead ? checkedImage : uncheckedImage
        hasBeenReadButton.setImage(image, for: .normal)
        
    }

}
