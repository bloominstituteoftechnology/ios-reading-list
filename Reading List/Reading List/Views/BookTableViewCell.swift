//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dustin Koch on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    weak var delegate: BookTableViewCellDelegate?
    
    var book: Book?
    
    func updateViews(book: Book){
        bookName.text = book.title
        var correctImage: String
        if book.hasBeenRead == true {
            correctImage = "checked"
        } else {
            correctImage = "unchecked"
        }
        
        readButtonView.setImage(UIImage(named: correctImage), for: UIControlState.normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK: - Outlets
    
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var readButtonView: UIButton!
    @IBAction func readButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
//    let title: String
//    let reasonToRead: String
//    let hasBeenRead: Bool
    
}
