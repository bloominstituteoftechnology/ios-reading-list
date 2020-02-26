//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Bhawnish Kumar on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    
    
    @IBAction func buttonInAction(_ sender: UIButton) {
    }
    
    var book: Book? {
    didSet {
           updateViews()
       }
    }
    
    
        func updateViews() {
        guard let book = book else { return }
            
            bookLabel.text = book.title
            
            let image = book.hasBeenRead ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
            bookButton.setImage(image, for: .normal)
            
    }
       
           
}
