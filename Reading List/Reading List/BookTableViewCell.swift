//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Thomas Cacciatore on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    var book: Book?
    weak var delegate: BookTableViewCellDelegate?
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func updateViews() {
        guard let bookTitle = book?.title else { return }
        cellLabel.text = bookTitle
        if book?.hasBeenRead == true {
            cellButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            cellButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        
    }
    
    
    @IBAction func cellButtonTapped(_ sender: Any) {
        
        delegate?.toggleHasBeenRead(for: self)
        
    }
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    

}
