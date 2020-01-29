//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Chris Gonzales on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    var book: Book?
    var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var readCheckBox: UIButton!
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBAction func readBoxTapped(_ sender: Any) {
        
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
    }
    
    
    
    func updateViews(){
        
        let checkedBox = UIImage(named: "checked")
        let uncheckedBox = UIImage(named: "unchecked")
        
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        
      if book.hasBeenRead == false {
        readCheckBox.imageView?.image = checkedBox
      } else {
        readCheckBox.imageView?.image = uncheckedBox
        }
        
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    


}
