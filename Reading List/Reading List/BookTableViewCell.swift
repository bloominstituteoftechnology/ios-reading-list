//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by beth on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var book: Book? {
          didSet {
              updateViews()
          }
      }

      var delegate: BookTableViewCellDelegate?

      /// Sets the book title label and whether the button is checked or unchecked
      private func updateViews() {
           guard let book = book else { return }

           bookLabel.text = book.title
           if (book.hasBeenRead) {
               let image = UIImage(named: "checked")
               checkButton.setImage(image, for: .normal)
           } else {
               let image = UIImage(named: "unchecked")
               checkButton.setImage(image, for: .normal)
           }
       }
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
            delegate?.toggleHasBeenRead(for: self)
    }
}
