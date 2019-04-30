//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Thomas Cacciatore on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    var book: Book?

    var delegate: BookTableViewCellDelegate?
    
    func updateViews() {
        guard let book = book else { return }
        
        cellLabel.text = book.title
        if book.hasBeenRead == true {
            cellButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            cellButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    @IBAction func cellButtonTapped(_ sender: Any) {
        //Call delegate property's toggleHasBeenRead(for cell: ) function.
    }
    
}
