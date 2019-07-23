//
//  BookCell.swift
//  Reading List
//
//  Created by Jeffrey Santana on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var toggleReadBtn: UIButton!
	
	var book: Book? {
		didSet {
			configCell()
		}
	}
	
	//Warning: do this
	@IBAction func toggleReadBtnAction(_ sender: UIButton) {
	}
	
	private func configCell() {
		guard let book = book else { return }
		titleLbl.text = book.title
		toggleReadBtn.imageView?.image = book.isRead ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
	}
}
