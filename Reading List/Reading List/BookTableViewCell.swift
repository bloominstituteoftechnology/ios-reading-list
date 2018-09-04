//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Moin Uddin on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel?.text = book.title
        book.hasBeenRead ? checkButton?.setImage(UIImage(named: "checked.png"), for: .normal) : checkButton?.setImage(UIImage(named: "unchecked"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    
    
    @IBAction func toggleRead(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    

}
