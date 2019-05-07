//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Taylor Lyles on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

	var book: Book? {
		didSet {
			updateViews()
		}
	}
	weak var delegate: BookTableViewCellDelegate?
	
	
	private func updateViews() {
		guard let book = book else { return }
		title.text = book.title
		
		
		var image: UIImage!
		
		if book.hasBeenRead {
			image = UIImage(named: "checked")
		} else {
			image = UIImage(named: "unchecked")
		}
		button.setImage(image, for: .normal)
	}
	
	@IBOutlet weak var title: UILabel!

	@IBOutlet weak var button: UIButton!
	
	@IBAction func actionButton(_ sender: Any) {
		   delegate?.toggleHasBeenRead(for: self)
	}
	
	
}
