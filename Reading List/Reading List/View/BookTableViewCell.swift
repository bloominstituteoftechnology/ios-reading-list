//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Harmony Radley on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit


class BookTableViewCell: UITableViewCell {

    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var readBooks: UILabel!
    
    @IBOutlet weak var checkedBox: UIButton!
    
    
    @IBAction func addBook(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var book: Book?
    

    
    
    

}
