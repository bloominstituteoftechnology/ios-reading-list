//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by admin on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book?
    
    private func updateViews() {
        guard let book = book else { return }
        
        titleLabel.text = book.title
        hasBeenReadButton.isSelected = book.hasBeenRead
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addBook(_ sender: UIBarButtonItem) {
        
    }
    

}
