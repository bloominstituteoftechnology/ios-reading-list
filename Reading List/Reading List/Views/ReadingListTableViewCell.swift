//
//  ReadingListTableViewCell.swift
//  Reading List
//
//  Created by Joel Groomer on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblBookTitle: UILabel!
    @IBOutlet weak var btnHasBeenRead: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func hasBeenReadTapped(_ sender: Any) {
    }
}
