//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lambda_School_loaner_226 on 2/16/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var bookController: BookController?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let book = book else {return}
        
        bookNameLabel.text = book.title
        let isReadImage = book.hasBeenRead ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
        hasBeenReadButton.setImage(isReadImage, for: .normal)
        
    }
    @IBAction func hasBeenReadButtonTapped(_ sender: UIButton) {
        
    }
    

}
