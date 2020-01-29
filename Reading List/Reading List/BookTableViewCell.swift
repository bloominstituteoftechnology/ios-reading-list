//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Enrique Gongora on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?{
        didSet{
            updateViews()
        }
    }

    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var checkMarkButton: UIButton!
    
    
    
    @IBAction func checkMarkButtonPressed(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
    }
    
    
    weak var delegate: BookTableViewCellDelegate?
    
    func updateViews() {
        if let book = book{
            bookTitleLabel.text = book.title
        }
        if book?.hasBeenRead == true{
            checkMarkButton.setImage(UIImage(named: "checked"), for: .normal)
        }else{
            checkMarkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        
    }

}
