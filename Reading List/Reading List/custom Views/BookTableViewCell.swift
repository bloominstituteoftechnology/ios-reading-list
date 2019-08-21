//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by brian vilchez on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: UITableViewCell)
}

class BookTableViewCell: UITableViewCell {
    
    var delegate: BookTableViewCellDelegate?
    var book:Book? {
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    @IBAction func BookCheckMarkButton(_ sender: UIButton) {
       delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else {return}
        var updateBook = book
        bookNameLabel.text = book.title
        if checkBoxButton.currentImage == UIImage(named: "checked") {
            updateBook.hasBeenRead = true
        } else if checkBoxButton.currentImage == UIImage(named: "unchecked"){
            updateBook.hasBeenRead = false
        }
    }

}
