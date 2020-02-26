//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Bhawnish Kumar on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell, UITableViewDelegate {
    
    
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    
    
    
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
  var delegate: BookTableViewCellDelegate?
    
    @IBAction func buttonInAction(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: BookTableViewCell(style: .default , reuseIdentifier: "BookViewCell"))
    }
       
           
}

