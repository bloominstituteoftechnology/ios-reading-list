//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Osha Washington on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var readCheckedBox: UIButton!
    
    //MARK: - IBAction
    @IBAction func readCheckedBox(_ sender: Any) {
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
