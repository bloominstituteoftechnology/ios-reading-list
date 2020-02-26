//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Harmony Radley on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit


class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var readBooks: UILabel!
    @IBOutlet weak var checkedBox: UIButton!
    
    
    var delegate: BookTableViewCellDelegate?
    
    @IBAction func addBookTapped(_ sender: UIBarButtonItem) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let book = book {
            readBooks.text = book.title
            switch book.hasBeenRead {
            case true:
                checkedBox.setImage(UIImage(named: "checked"), for: .normal)
            case false:
                checkedBox.setImage(UIImage(named: "unchecked"), for: .normal)
            }
        }
    }
    
    
    

}
