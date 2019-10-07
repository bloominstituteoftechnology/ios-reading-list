//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Alex Thompson on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
    }
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    
    private func updateViews() {
        guard let book = book else {return}
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
