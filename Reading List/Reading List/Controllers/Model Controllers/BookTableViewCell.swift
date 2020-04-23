//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Nonye on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
//MARK: OUTLETS & ACTIONS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func buttonTapped(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.toggleHasBeenRead(for: self)
    }
    
//MARK: Part 3 - Wiring Everything Up
    var book: Book?
    weak var delegate: BookTableViewCellDelegate?
    func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        if book.hasBeenRead {
            button.setImage((#imageLiteral(resourceName: "checked")), for: .normal) } else {
            button.setImage((#imageLiteral(resourceName: "unchecked")), for: .normal)
            
        }
    }
}


