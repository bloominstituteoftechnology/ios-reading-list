//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Morgan Smith on 12/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bookLabel: UILabel!
    
    @IBOutlet weak var checkedLabel: UIButton!
    var delegate: BookTableViewCellDelegate?
    
    @IBAction func checkButton(_ sender: UIButton!) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    var book: Book?
    
    func updateViews() {
           guard let book = book else { return }
           bookLabel.text = book.title
           checkedLabel.imageView?.image = UIImage(named: "unchecked")
        
       }
    
    

}
