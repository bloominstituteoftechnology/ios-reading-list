//
//  CustomBookCell.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var bookCover: UIImageView!
    
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
   
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UIButton!
    
    weak var delegate: BookTableViewDelegate?
    
    
    private func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        bookCover.image = UIImage(data: book.image,scale:1.0)
        
        if book.hasBeenRead == false {
            statusLabel.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        } else {
            statusLabel.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
   
    @IBAction func statusTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
        
    }
    
    
}
