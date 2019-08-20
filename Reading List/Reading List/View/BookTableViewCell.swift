//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Joshua Sharp on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookBeenReadButton: UIButton!
    
    var book: Book?{
        didSet {
            updateViews()
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

    private func updateViews( ) {
        guard let book = book else {return}
        bookTitleLabel.text = book.title
        if book.hasBeenRead {
            bookBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            bookBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    @IBAction func beenReadButtonTapped(_ sender: UIButton) {
        
    }
}
