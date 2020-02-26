//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Nichole Davidson on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var readCheckBox: UIButton!
    
    var book: Book?
    
    
    func updateViews() {
        
        guard let book = book else { return }
        bookTitle.text = book.title
        
        if book.hasBeenRead == true {
            readCheckBox.imageView?.image = UIImage(named: "checked")
        } else {
            readCheckBox.imageView?.image = UIImage(named: "unchecked")
        }
    }
    
    @IBAction func readBoxChecked(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
