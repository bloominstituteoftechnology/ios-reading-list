//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Richard Gibbs on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell, BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        
    }
    
 
    var book: Book?

    weak var delegate: BookTableViewCellDelegate?
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBAction func checkBoxSelected(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        checkBoxButton.setImage(UIImage(named: "unchecked"), for: .normal)
        checkBoxButton.setImage(UIImage(named: "checked"), for: .selected)
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

    

