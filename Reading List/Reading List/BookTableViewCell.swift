//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Farhan on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell{
    
    var book: Book?
    weak var delegate: BookTableViewCellDelegate?

    @IBOutlet weak var bookLabel: UILabel!

    @IBOutlet weak var checkbutton: UIButton!
    
    @IBAction func checkMark(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews(){
        
        bookLabel.text = book?.title
        let checkImage = UIImage(named: "checked")
        let uncheckedImage = UIImage(named: "unchecked")
        if (book?.hasBeenRead == true){
            checkbutton.setBackgroundImage(checkImage, for: .normal)
        } else if (book?.hasBeenRead == false) {
            checkbutton.setBackgroundImage(uncheckedImage, for: .normal)
        }
        
        
        
    }

}
