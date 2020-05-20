//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Ian Becker on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var readButton: UIButton!
    @IBAction func isNotReadButton(_ sender: UIButton) {
        toggleHasBeenRead(for: <#T##BookTableViewCell#>)
    }
    
    var book: Book?
    weak var delegate: BookTableViewCellDelegate?
    
    func updateViews() {
        guard let book = book else { return }
        
        bookTitle.text = book.title
        readButton.setImage(UIImage(named: "unchecked"), for: .normal)
        readButton.setImage(UIImage(named: "checked"), for: .selected)
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
