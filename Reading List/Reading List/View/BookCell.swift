//
//  BookCellTableViewCell.swift
//  Reading List
//
//  Created by Kenny on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadOut: UIButton!
    
    
    @IBAction func hasBeenReadTapped(_ sender: UIButton) {
        
    }
    
    
    var book: Book? {
        didSet {
            self.titleLabel.text = book?.title
            setBookHasBeenReadUI()
        }
    }
    
    func setHasBeenRead() {
        book?.hasBeenRead = true
        setBookHasBeenReadUI()
    }
    
    func setBookHasBeenReadUI() {
        if book?.hasBeenRead ?? true {
            print("tapped")
            hasBeenReadOut.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasBeenReadOut.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

}
