//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_201 on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    
    weak var delegate: BookTableViewCellDelegat?
    
    
    
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
    }
    
    private func updateViews() {
        guard let book = book else {return}
        bookTitleLabel.text = book.title
        let checkedImage = UIImage(named: "checked")
        let unCheckedImage = UIImage(named: "unchecked")
        if book.hasBeenRead == true {
            checkBoxOutlet.setImage(checkedImage, for: .normal)
            
        }else {
            checkBoxOutlet.setImage(unCheckedImage, for: .normal)
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

}
