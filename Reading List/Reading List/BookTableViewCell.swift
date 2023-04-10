//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Harm on 3/17/23.
//  Copyright © 2023 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private var book: Book?
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBAction func readTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func set(book: Book?) {
        self.book = book
        updateViews()
    }
    
    private func updateViews() {
        //guard isViewLoaded else { return }
        label.text = book?.title
        
        if book?.hasBeenRead == true {
            button.imageView?.image = UIImage(named: "checked")
        } else {
            button.imageView?.image = UIImage(named: "unchecked")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
