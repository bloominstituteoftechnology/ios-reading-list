//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jonathan Ferrer on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateViews(){
        titleLabel.text = book?.title
        if book?.hasBeenRead == true{
            hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else{
            hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }


    var book: Book? {
        didSet {
            updateViews()
        }
    }
    var delegate: BookTableViewCellDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    @IBAction func hasBeenReadButtonPressed(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
