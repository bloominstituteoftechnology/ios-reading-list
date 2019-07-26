//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by brian vilchez on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var CheckedBUtton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var book: Book? {
        
        didSet {
            updateViews()
        }
    }
    
    @IBAction func CheckBoxButton(_ sender: UIButton) {
    }
    func updateViews(){
        guard let book = book else {return}
        nameLabel.text = book.title
    }
}
