//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Ufuk Türközü on 12.11.19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var check: UIButton!
    @IBAction func checkTapped(_ sender: Any) {
        toggleHasBeenRead(for cell: BookTableViewCell)
    }
    
    var book: Book?
    
    var delegate: BookTableViewCellDelegate?
    
    var booksTitle: Book? {
        didSet {
            updateViews()
        }
    }
    
    func updateviews() {
        guard let book = booksTitle else { return }
            
        bookTitle.text = book.booksTitle
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
