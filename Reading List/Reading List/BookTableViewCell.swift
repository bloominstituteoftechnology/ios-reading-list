//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Drew Miller on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var bookLabelOutlet: UILabel!
    @IBOutlet weak var readBookCheckedOutlet: UIButton!
   //Action
    @IBAction func readBookCheckedAction(_ sender: Any) {
        func toggleHasBeenRead(for: BookTableViewCellDelegate) {
    }

    
var book: Book?
        weak var _: BookTableViewCellDelegate?

func updateViews() {
    guard let book = book else { return }
    
    
    bookLabelOutlet.text = book.title
    readBookCheckedOutlet.setImage(UIImage(named: "unchecked"), for: .normal)
    readBookCheckedOutlet.setImage(UIImage(named: "checked"), for: .normal)
    
    }
}
}
