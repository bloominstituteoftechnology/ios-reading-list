//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Karen Rodriguez on 2/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenRead: UIButton!
    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: <#T##BookTableViewCell#>)
    }
    
    var book: Book?
    
    weak var delegate: BookTableViewCellDelegate?
    
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
        titleLabel.text = book.title
        if book.hasBeenRead {
            hasBeenRead.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            hasBeenRead.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        
    }

}
