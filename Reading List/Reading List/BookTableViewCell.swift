//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Kennon Keys Ward on 6/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func readButtonTapped(_ sender: Any) {
    }
    
}
