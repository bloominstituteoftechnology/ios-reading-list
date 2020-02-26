//
//  ReadingListTableViewCell.swift
//  Reading List
//
//  Created by Lydia Zhang on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewCell: UITableViewCell {
    
  
    var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var seenLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateViews() {
        guard let book = book else {
            return
        }
        bookTitleLabel.text = book.title
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func seenTapped(_ sender: Any) {
        self.book?.hasBeenRead = !(self.book?.hasBeenRead ?? false)
        if self.book?.hasBeenRead == true {
            seenLabel.imageView?.image = #imageLiteral(resourceName: "checked")
        } else {
            seenLabel.imageView?.image = #imageLiteral(resourceName: "unchecked")
        }
 
        delegate?.toggleHasBeenRead(for: self)
    }
}
