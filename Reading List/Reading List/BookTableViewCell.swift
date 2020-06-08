//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by James Sedlacek on 6/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    
    var delegate: BookTableViewCellDelegate?
    
    @IBAction func checkboxTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var checkbox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateViews() {
        guard let theBook = book else { return }
        bookTitleLabel.text = theBook.title
        if theBook.hasBeenRead {
            checkbox.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkbox.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

}
