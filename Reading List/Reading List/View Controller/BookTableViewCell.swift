//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by De MicheliStefano on 31.07.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // MARK: - Methods
    
    @IBAction func selectHasBeenRead(_ sender: Any) {
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var bookTitleTextLabel: UILabel!
    @IBOutlet weak var hasBeenReadButtonLabel: UIButton!
    

}
