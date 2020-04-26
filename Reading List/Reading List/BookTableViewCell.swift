//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Josh Kocsis on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateViews() {
        guard let book = self.book else { return }
        bookLabel.text = book.title
        if book.hasBeenRead == false {
            if let box = UIImage(named: "unchecked.png") {
                hasBeenReadButton.setImage(box, for: .normal)
            } else {
                let box = UIImage(named: "checked.png")
                hasBeenReadButton.setImage(box, for: .normal)
            }
        }
    }
}
