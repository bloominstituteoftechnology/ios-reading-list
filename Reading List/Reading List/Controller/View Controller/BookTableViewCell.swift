//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lambda_School_loaner_226 on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var hasReadButton: UIButton!
    
    var book: Book?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(bookLabel: String, hasReadButton: String)
    {
        
    }
    
    
    
    
    
    @IBAction func hasReadButtonTapped(_ sender: Any)
    {
        
    }
    
}
