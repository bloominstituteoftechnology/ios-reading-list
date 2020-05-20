//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Bryan Cress on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell, BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCellDelegate) {
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        }
   
    var book: Book?
    weak var delegate: BookTableViewCellDelegate?
    

    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func readButtonToggle(_ sender: UIButton) {
        func toggleHasBeenRead(for: BookTableViewCell) {
            delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
    guard let book = book else { return }
    
        bookLabel.text = book.title
        readButton.setImage(UIImage(named: "unchecked"), for: .normal)
        readButton.setImage(UIImage(named: "checked"), for: .normal)
    }
}

}
