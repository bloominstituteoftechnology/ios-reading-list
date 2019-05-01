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
		guard let book = book else { return }
		let imgStr = book.hasBeenRead ? "checked" : "uncheked"
		hasBeenReadButtonOutlet.imageView?.image = UIImage(named: imgStr)
		bookTitleLabel.text = "Reason to read: " + book.reasonToRead
		
	}
	
	@IBAction func hasBeenReadButton(_ sender: Any) {
		//delegate work
		delegate?.toggleHasBeenRead(for: self)
		print("pressed")
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
