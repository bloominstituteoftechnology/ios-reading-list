//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Aaron Peterson on 4/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var hasReadButton: UIButton!
    
    var book: Book? {
        didSet {
            self.updateViews()
        }
    }
    var delegate: BookTableViewCellDelegate?
    
    @IBAction func hasReadButtonTapped(_ sender: Any) {
        //delegate.toggleHasBeenRead(for cell: self)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitle.text = book.title
        if book.hasBeenRead == true {
            hasReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

}
