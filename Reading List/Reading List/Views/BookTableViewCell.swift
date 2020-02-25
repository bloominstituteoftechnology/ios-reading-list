//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Shawn Gee on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBAction func checkMarkToggled(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
    }
    
    func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        updateCheckMark(checked: book.hasBeenRead)
    }
    
    func updateCheckMark(checked: Bool) {
        let checkMarkImage = checked ? UIImage(named: "checked") : UIImage(named: "unchecked")
        checkMarkButton.setImage(checkMarkImage, for: .normal)
    }
}
