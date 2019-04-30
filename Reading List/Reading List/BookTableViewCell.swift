//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Mitchell Budge on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import Foundation

class BookTableViewCell: UITableViewCell {
    
    var delegate: BookTableViewCellDelegate?
    
    var book: Book?
    
    func updateViews() {
        guard let title = book?.title else { return }
        bookLabel.text = title
        guard let hasRead = book?.hasBeenRead else { return }
        
        if hasRead == true {
            bookButton.setImage(UIImage(named: "checked.png"), for: .selected)
        } else {
            bookButton.setImage(UIImage(named: "unchecked.png"), for: .normal)
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
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBAction func bookButtonPressed(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: <#T##BookTableViewCell#>)
    }
    
}
