//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Mark Poggi on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBAction func hasBeenReadTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenReadFor(cell: self)
    }
    
     // MARK: - Private Methods
    
    func updateViews() {
        guard let book = book else {return}
        
        titleLabel.text = book.title
        
        /*  Create an `updateViews()` function that takes the values in the `book` property and sets its `title` in the label, and set the button's image to either the checked or unchecked image that are in the assets folder.
           - **NOTE:** You may either use image literals or the `UIImage(named: String)` initializer to get access to the checkbox images from the assets folder. */
        
        let image = book.hasBeenRead ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
        
        hasBeenReadButton.setImage(image, for: .normal)
    }
    
        // MARK: - Properties
    
    weak var delegate: BookTableViewCellDelegate?

    var book: Book? {
        didSet {
            updateViews()
        }
    }
      
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var hasBeenReadButton: UIButton!
}
