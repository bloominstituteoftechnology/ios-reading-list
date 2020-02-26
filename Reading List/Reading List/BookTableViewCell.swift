//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Shawn James on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var book: Book?
    var delegate: BookTableViewCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        if let book = book {
            titleLabel.text = book.title
            switch book.hasBeenRead {
            case true:
                checkBox.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            default:
                checkBox.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
        }
        
    }
    
}
