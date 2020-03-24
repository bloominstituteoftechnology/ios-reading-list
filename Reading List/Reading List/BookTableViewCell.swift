//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Hunter Oppel on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell
{
    var book: Book?
    
    var delegate: BookTableViewCellDelegate?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    func updateViews(book: Book) {
        nameLabel.text = book.title
        
        if book.hasBeenRead {
            hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func toggleHasBeenRead(_ sender: Any) {
        guard let sender = sender as? BookTableViewCell else { return }
        delegate?.toggleHasBeenRead(for: sender)
    }
    
}
