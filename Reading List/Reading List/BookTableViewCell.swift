//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Taylor Lyles on 7/23/19.
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
	
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var readButton: UIButton!
	
	@IBAction func checkReadButton(_ sender: UIButton) {
		delegate?.toggleHasBeenRead(for: self)
	}
	
	private func updateViews() {
		guard let book = book else { return }
		title.text = book.title
		
		var image: UIImage!
		
		if book.hasBeenRead {
			image = UIImage(named: "checked")
		} else {
			image = UIImage(named: "unchecked")
		}
		readButton.setImage(image, for: .normal)
	}

}
