//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by LambdaSchoolVM_Catalina on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    //outlets
    
    @IBOutlet weak var bookTitleLbl: UILabel!
    @IBOutlet weak var readUnreadBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //actions
    @IBAction func bookReadBtnActivated(_ sender: Any) {
    }
    
    

}
