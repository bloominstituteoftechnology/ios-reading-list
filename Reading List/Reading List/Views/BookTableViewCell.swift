//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jarren Campos on 2/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var seenButton: UIButton!
    
    var book: Book?{
        didSet{
            updateViews()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }

    //MARK: - IBAction
    
    @IBAction func seenUnseenButton(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
    }
    
    var delegate: BookTableViewCellDelegate?
    
    func updateViews() {
        if let book = book {
            titleLabel.text = book.title
        }
        if book?.hasBeenRead == true {
            seenButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            seenButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

}
