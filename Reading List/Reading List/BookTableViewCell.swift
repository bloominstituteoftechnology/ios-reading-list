//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Chris Dobek on 3/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var checkedButton: UIButton!
    
   weak var delegate: BookTableViewCellDelegate?
    
    @IBAction func checkedButton(_ sender: Any) {
        func toggleHasBeenRead(for cell: BookTableViewCell ){
            
        }
    }
    
var book: Book? {
       didSet {
           updateViews()
       }
   }

   func updateViews() {
       guard let book = book else {return}

       bookLabel.text = book.title
       let imageName = book.hasBeenRead ? "checked": "unchecked"
       let image = UIImage(named: imageName)
       checkedButton.setImage(image, for: .normal)
   }

   override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
   }

   @IBAction func hasReadButtonPressed(_ sender: UIButton) {
       delegate?.toggleHasBeenRead(for: self)
   }
}
