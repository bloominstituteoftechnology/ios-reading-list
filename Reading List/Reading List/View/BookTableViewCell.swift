//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Claudia Contreras on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet var bookLabel: UILabel!
    @IBOutlet var hasBeenReadButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        
    }
    
}
