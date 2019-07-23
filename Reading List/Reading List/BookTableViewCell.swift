//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Bradley Yin on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    var book : Book? {
        didSet{
            
        }
    }
    var delegate : BookTableViewCellDelegate?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    private func updateView(){
        guard let book = book else{return}
        nameLabel.text = book.name
        let image = book.hasBeenRead ? UIImage(named: "checked") : UIImage(named:"unchecked")
        checkButton.setImage(image, for: .normal)
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    

}
