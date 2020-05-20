//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Rebecca Overare on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    var book: Book?
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var bookReadButton: UIButton!
    
    @IBAction func bookRead(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func updateViews() {
        bookTitleLabel.text = book?.title
    }

}
