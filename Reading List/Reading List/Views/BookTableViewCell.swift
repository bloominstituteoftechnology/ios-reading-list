//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Marissa Gonzales on 4/22/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
       
    var delegate: BookTableViewCellDelegate?
    
    // Outlets
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    // Has been read action
    @IBAction func hasBeenReadAction(_ sender: UIButton) {
        
        delegate?.toggleHasBeenRead(for: <#T##BookTableViewCell#>)
    }

    func updateViews(book: Book) {
        
        let bookTitle = book.title
        
        bookLabel.text = bookTitle
        
        let unchecked = UIImage(named: "unchecked")
        let checked = UIImage(named: "checked")
        
        if book.hasBeenRead == true {
            hasBeenReadButton.setImage(checked, for: .normal)
        } else {
            hasBeenReadButton.setImage(unchecked, for: .normal)
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

}
