//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by LaFleur on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol ToggleSeenDelegate {
    func isSeenButtonTapped(book: Book)
    
}

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var seenButton: UIButton!
    
    @IBAction func toggleIsSeen(_ sender: Any) {
        
        book?.hasBeenRead()
        
        updateViews()
        
    }
    
    
    var delegate: ToggleSeenDelegate?

    var book: Book? {
        didSet {
            updateViews()
        }
        
    }
    
    private func updateViews() {
        guard let book = book else { return }
        
        // sets the text of both labels to the info from the Star Array
        nameLabel.text = book.title
        if book.hasBeenRead == true {
            seenButton.setImage(image: .checked, for: UIControlState)
            
        } else {
            seenButton.setImage(image: .unchecked, for: UIControlState)
        
        }
    }

}
