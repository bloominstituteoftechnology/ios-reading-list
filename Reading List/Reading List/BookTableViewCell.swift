//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lambda_School_Losaner_256 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
     
    

    var book: Book? {
        didSet() {
        updateViews()
    }
    }
    
    var delegate: BookTableViewCellDelegate?
   
func updateViews() {
    guard let book = book else { return }
    
    bookLabel.text = book.title
    if (book.hasBeenRead) {
        let image = UIImage(named: "checked")
        checkButton.setImage(image, for: .normal)
    } else {
        let image = UIImage(named: "unchecked")
        checkButton.setImage(image, for: .normal)
        
    }
        
    }
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(ofr: self)
        
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
    


