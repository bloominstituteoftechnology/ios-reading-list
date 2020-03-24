//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Cameron Collins on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    //Variables
    var book: Book?
    var delegate: BookTableViewCellDelegate?
    
    //Outlets
    @IBOutlet weak var BookTitle: UILabel!
    @IBOutlet weak var ButtonRead: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Actions
    @IBAction func ReadButtonPressed(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    //Functions
    func updateViews() {
        guard let myBook = book else { return }
        BookTitle.text = myBook.title
        ButtonRead.setImage(UIImage(named: "unchecked"), for: .normal)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
