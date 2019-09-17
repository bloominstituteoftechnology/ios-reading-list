//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by admin on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    

    var book: Book?
    
    var delegate: BookTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateViews() {
        guard let book = book else { return }
        
        titleLabel.text = book.title
        
        if readButton.isSelected == true {
            readButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            readButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func readButtonAction(_ sender: UIButton) {
        let cell = self
        delegate?.toggleHasBeenRead(for: cell)
    }
    
}
