//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Claudia Contreras on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet var bookLabel: UILabel!
    @IBOutlet var hasBeenReadButton: UIButton!
    
    
    //MARK: - Properties
    var book: Book?
    var delegate: BookTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateViews() {
        bookLabel.text = book?.title
        var boxImage: UIImage
        if (book?.hasBeenRead) != nil {
            boxImage = UIImage(named: "checked")!
        } else {
            boxImage = UIImage(named: "unchecked")!
        }

        hasBeenReadButton.setImage(boxImage, for: .normal)
    }
    
    //MARK: - IBActions
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
}
