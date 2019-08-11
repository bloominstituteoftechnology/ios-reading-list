//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Bobby Keffury on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit


class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBAction func bookButtonTapped(_ sender: Any) {
        //number 7 on the book table view cell.
        delegate?.toggleHasBeenRead(for: <#T##BookTableViewCell#>)
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
       //Need to set the image to either checked or unchecked
    }
    
    //Number 6 on the book table view cell.
    weak var delegate: BookTableViewCellDelegate?
    
    
    
    
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
