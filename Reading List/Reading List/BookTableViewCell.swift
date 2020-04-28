//
//  TableViewCell.swift
//  Reading List
//
//  Created by Ian French on 4/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    
    
    @IBAction func checkboxPressed(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
    }
    
    var book: Book? {
    didSet {
    updateViews()}
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    
    func updateViews() {
        if let book = book {
            bookTitleLabel.text = book.title
        }
        if book?.hasBeenRead == false {
           checkBoxOutlet.setImage(UIImage(named: "checked"), for: .normal)
        }else {
        checkBoxOutlet.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    
    
    
    
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
