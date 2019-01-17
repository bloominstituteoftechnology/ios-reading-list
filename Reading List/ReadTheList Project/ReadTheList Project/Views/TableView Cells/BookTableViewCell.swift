//
//  BookTableViewCell.swift
//  ReadTheList Project
//
//  Created by Michael Flowers on 1/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit



class BookTableViewCell: UITableViewCell {
    
    var book: Book?

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var checkMarkProperties: UIButton!
    
    
    
    @IBAction func changeCheckMark(_ sender: UIButton) {
    }
    
    func updateViews(){
        guard let passedInBook = book else { return }
        bookTitleLabel.text = passedInBook.title
        
//        passedInBook.hasBeenRead ? checkMarkProperties.imageView?.image = UIImage(named: "checked") : checkMarkProperties.imageView?.image = UIImage(named: "unchecked")
        
        if passedInBook.hasBeenRead {
            checkMarkProperties.imageView?.image = UIImage(named: "checked")
        } else {
            checkMarkProperties.imageView?.image = UIImage(named: "unchecked")
        }
        
//        passedInBook.hasBeenRead == true ? checkMarkProperties.imageView?.image = UIImage(named: "checked") : checkMarkProperties.imageView?.image = UIImage(named: "unchecked")
    }
}
