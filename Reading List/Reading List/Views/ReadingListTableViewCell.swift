//
//  ReadingListTableViewCell.swift
//  Reading List
//
//  Created by Joel Groomer on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblBookTitle: UILabel!
    @IBOutlet weak var btnHasBeenRead: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    var delegate: ReadingListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        lblBookTitle.text = book.title
        btnHasBeenRead.setImage(book.hasBeenRead ? UIImage(named: "checked") : UIImage(named: "unchecked"), for: .normal)
    }
}
