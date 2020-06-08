//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dojo on 6/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet var labelText: UILabel!
    @IBOutlet var buttonPic: UIButton!

    @IBAction func tappedButton(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }

    weak var delegate: BookTableViewDelegate?

    var book: Book? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        guard let book = book else {return}

        labelText.text = book.title

        if book.hasBeenRead {
            buttonPic.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            buttonPic.setImage(UIImage(named: "unchecked"), for: .normal)
        }

    }

}
