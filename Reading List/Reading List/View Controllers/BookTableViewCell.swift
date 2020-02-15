//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Breena Greek on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
//    weak var delegate: BookTableViewCellDelegate?

    var book: Book?
    
    func updateViews() {
        bookLabel.text = book?.title
        if readToggle.isSelected {
            UIImage(named: "checked")
        } else {
            UIImage(named: "unchecked")
        }
    }
    // MARK: IBOutlets
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var readToggle: UIButton!
    
    // MARK: IBActions
    
//    @IBAction func readToggleButton(_ sender: UIButton) {
////        toggleHasBeenRead(for: delegate)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
