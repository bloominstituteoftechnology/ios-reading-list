//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by admin on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookReadButton: UIButton!
    
    @IBAction func bookReadAction(_ sender: Any) {
        toggleHasBeenRead(for: BookTableViewCell)
    }
    
    var book: Book?
    
    func updateViews() {
        guard let book = book else { return }
        
        bookLabel.text = book.title
        bookReadButton.isSelected = bookReadButton.setImage(selectedImage, for: UIControl.State.normal)
    }
    
    weak var delegate: BookTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
