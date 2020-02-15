//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Claudia Contreras on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet var bookLabel: UILabel!
    @IBOutlet var hasBeenReadButton: UIButton!
    
    
    //MARK: - Properties
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    var delegate: BookTableViewCellDelegate?
    
    func updateViews() {
        guard let book = book else { return }
        
        bookLabel.text = book.title
        
        let boxImage: UIImage = book.hasBeenRead ? UIImage(named: "checked")! : UIImage(named: "unchecked")!

        hasBeenReadButton.setImage(boxImage, for: .normal)
    }
    
    //MARK: - IBActions
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
}
