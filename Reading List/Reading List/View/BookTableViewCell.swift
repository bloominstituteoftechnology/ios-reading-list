//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Juan M Mariscal on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var readBookBtn: UIButton!
    
    var book: Book? {
        didSet{
            self.updateViews()
        }
    }
    
    var delegate: BookTableViewCellDelegate?
    
    func updateViews() {
        bookLabel.text = book?.title
        if book?.hasBeenRead == true {
            readBookBtn.imageView?.image = UIImage(named: "checked")
        } else {
            readBookBtn.imageView?.image = UIImage(named: "unchecked")
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func readBookBtnPressed(_ sender: Any) {
        //delegate?.toggleHasBeenRead(for: )
    }
    
}
