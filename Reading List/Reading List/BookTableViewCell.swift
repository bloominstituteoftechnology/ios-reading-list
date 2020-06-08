//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Gladymir Philippe on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}

class BookTableViewCell: UITableViewCell {
    
    weak var delegate: BookTableViewCellDelegate?

    @IBOutlet weak var bookNameLabel: UILabel!
    
    @IBOutlet weak var checkedButtonLabel: UIButton!
    var button: [UIButton] = []
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let book = book else { return }
        
        bookNameLabel.text = book.title
        if book.hasBeenRead {
            self.checkedButtonLabel.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            self.checkedButtonLabel.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
    }
        
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func checkedButton(_ sender: Any) {
        
        func toggleHasBeenRead(for cell: BookTableViewCell) {
            
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


    
    

