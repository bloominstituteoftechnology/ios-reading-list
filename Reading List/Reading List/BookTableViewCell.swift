//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_64 on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func updateViews() {
        guard let book = book else { return }
        bookLabel.text = book.title
        let bookButton = book.hasBeenRead ? UIImage(named: "checked") : UIImage(named: "unchecked")
        boxButton.setImage(bookButton, for: .normal)
    }

    
    
    
    weak var delegate: BookTableViewCellDelegate?
    
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var boxButton: UIButton!
    
    
    @IBAction func boxButtonTapped(_ sender: Any) {
        toggleHasBeenRead(for cell: "TableViewCell")
    }
}
