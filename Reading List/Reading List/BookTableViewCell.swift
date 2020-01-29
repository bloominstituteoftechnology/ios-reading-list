//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Keri Levesque on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

     @IBOutlet weak var BookTitleLabel: UILabel!
    
    @IBOutlet weak var readCheckButton: UIButton!
    
    var book: Book? {
           didSet {
               updateViews()
           }
       }
    
      var delegate: BookTableViewCellDelegate?
      
      /// Sets the book title label and whether the button is checked or unchecked
      private func updateViews() {
           guard let book = book else { return }

           BookTitleLabel.text = book.title
           if (book.hasBeenRead) {
               let image = UIImage(named: "checked")
               readCheckButton.setImage(image, for: .normal)
           } else {
               let image = UIImage(named: "unchecked")
               readCheckButton.setImage(image, for: .normal)
           }
       }
      
 @IBAction func checkButton(_ sender: UIButton) {
     delegate?.toggleHasBeenRead(for: self)
 }

}
