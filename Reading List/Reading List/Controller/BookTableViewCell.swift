//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Mark Poggi on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    
    @IBOutlet weak var BookLabel: UILabel!
    @IBOutlet weak var BookButtonOutlet: UIButton!
    @IBAction func BookButton(_ sender: UIButton) {
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
