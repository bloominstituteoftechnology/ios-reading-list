//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dustin Koch on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK: - Outlets
    
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var readButtonView: UIButton!
    @IBAction func readButtonTapped(_ sender: UIButton) {
        
    }
    
    
    
}
