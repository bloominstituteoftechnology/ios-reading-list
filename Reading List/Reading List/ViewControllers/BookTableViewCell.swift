//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Hector Steven on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
	
	
	
	
	private func updateViews() {
		guard let book = book  else {
				
				
				return
		}
		let imgStr = book.hasBeenRead ? "checked" : "unchecked"
		let image = UIImage(named: imgStr)
		
		hasBeenReadButtonOutlet?.setImage(image, for: .normal)
		
		bookTitleLabel.text = book.title
		
	}
	@IBAction func hasBeenReadButtonPressed(_ sender: UIButton) {
		delegate?.toggleHasBeenRead(for: self)
		//updateViews()
	}

	
	@IBOutlet weak var hasBeenReadButtonOutlet: UIButton!
	@IBOutlet weak var bookTitleLabel: UILabel!
	
	weak var delegate: BookTableViewCellDelegate?
	
	var book: Book? {
		didSet {
			updateViews()
		}
	}
	
}
