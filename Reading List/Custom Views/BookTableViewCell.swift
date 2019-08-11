//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Eoin Lavery on 11/08/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var book: Book?
    
    func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        if book.hasBeenRead == true {
            hasBeenReadButton.imageView?.image = UIImage(named: "checked")
        } else {
            hasBeenReadButton.imageView?.image = UIImage(named: "unchecked")
        }
    }
    
    @IBAction func hasBeenReadTapped(_ sender: Any) {
        
    }
}
