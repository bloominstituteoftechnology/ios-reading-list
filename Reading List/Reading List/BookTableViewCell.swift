//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by macbook on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    
    var checkedImage = UIImage(named: "checked") //as UIImage?
    var uncheckedImage = UIImage(named: "unchecked") //as UIImage?
    
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    

    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        
        delegate?.toggleHasBeenRead(for: <#T##BookTableViewCell#>)
        
    }
    
    
    private func updateViews() {
        guard let book = book else { return }
        
        titleLabel.text = book.title
        
        switch book.hasBeenRead {
        case true:
            checkButton.setImage(checkedImage, for: .normal)
        case false:
            checkButton.setImage(uncheckedImage, for: .normal)
        }
        
//        distanceLabel.text = star.distanceDescription
    }
    

}
