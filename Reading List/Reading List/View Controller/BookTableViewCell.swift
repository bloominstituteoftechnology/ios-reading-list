//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_259 on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    // MARK: IBActions
    @IBAction func readButtonTapped(_ sender: Any) {
        //readButton.isSelected.toggle()
        delegate?.toggleHasBeenRead(for: self)
    }
    
    // MARK: Properties
    var book: Book?
    var delegate: BookTableViewCellDelegate?
    

    func updateViews() {
        guard let book = book, !book.title.isEmpty else { return }
        titleLabel.text = book.title
        if readButton.isSelected {
            readButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            readButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }

}
