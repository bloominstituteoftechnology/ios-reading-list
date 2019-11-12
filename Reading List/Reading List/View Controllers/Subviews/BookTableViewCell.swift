//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Alexander Supe on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    var delegate: BookTableViewCellDelegate?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func button(_ sender: UIButton) {
        delegate!.toggleHasBeenRead(for: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateViews()
    }
    
    
    
    func updateViews() {
    guard let book = book else { return }
        label.text = book.title
        if book.hasBeenRead {
            button.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
