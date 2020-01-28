//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_268 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var title
    @IBOutlet weak var button
    
    @IBAction func button() 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
