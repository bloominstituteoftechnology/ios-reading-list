//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_22 on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    func updateViews(){
        guard let book = book else {return}
        bookLabel.text = book.title
        let image = book.hasBeenRead ? UIImage(named: "checked") : UIImage(named: "unchecked")
        hasBeenRead.setImage(image, for: .normal)
    
    }
    
    weak var delegate: BookTableViewCellDelegate?
    var book: Book?
    @IBAction func hasBeenReadButton(_ sender: Any) {
       delegate?.toggleHasBeenRead(for: self)
    }
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var hasBeenRead: UIButton!
}
