//
//  BooksTableViewCell.swift
//  Reading List
//
//  Created by Kat Milton on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    // MARK: - Properties and Outlets
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookHasBeenReadButton: UIButton!
    
    var book: Book?
    
    weak var delegate: BookTableViewCellDelegate?
    
    
    // MARK: - Functions
    func updateViews() {
        guard let currentBook = self.book else { return }
        self.bookTitleLabel.text = currentBook.title
        let readStatus = self.book?.hasBeenRead
        if readStatus == false {
            bookHasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        } else {
            bookHasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        }
    }
    
    
    
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
    
    // MARK: - IBActions
    @IBAction func readButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    

}
