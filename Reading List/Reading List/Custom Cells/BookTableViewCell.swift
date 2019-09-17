//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Percy Ngan on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {


	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var buttonLabel: UIButton!

	
	var book: Book? {
		didSet {
			updateViews()
		}
	}

	var delegate: BookTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

    }


	@IBAction func buttonPressed(_ sender: UIButton) {
		delegate?.toggleHasBeenRead(for: self)
	}
	

	func updateViews() {
		guard let uwBook = book else { return }
		titleLabel.text = uwBook.title
		if uwBook.hasBeenRead {
			buttonLabel.setImage(UIImage(named: "checked"), for: .normal)
		} else {
			buttonLabel.setImage(UIImage(named: "unchecked"), for: .normal)
		}
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
