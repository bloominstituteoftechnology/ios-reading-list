//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dennis on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    var book: Book?
    
    //supposed to be a weak var delegate
    var delegate: BookTableViewCellDelegate?

   
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

    
    
    @IBAction func readButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        
        let checked = UIImage(named: "checked")
        let unchecked = UIImage(named: "unchecked")
        
        readButton.setImage(unchecked, for: .normal)
        readButton.setImage(checked, for: .selected)
    }



}




