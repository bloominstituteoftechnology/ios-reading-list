//
//  BookCell.swift
//  Reading List
//
//  Created by Ry Bautista on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol BookCellDelegate {
	func toggleReadStatus(for book: Book)
}

class BookCell: UITableViewCell {
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var toggleReadBtn: UIButton!
	
	var delegate: BookCellDelegate?
	var book: Book? {
		didSet {
			configCell()
		}
	}
	
	//Warning: do this
	@IBAction func toggleReadBtnAction(_ sender: UIButton) {
		guard let book = book else { return }
		delegate?.toggleReadStatus(for: book)
	}
	
	private func configCell() {
		guard let book = book else { return }
		let readImg = book.isRead ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
		titleLbl.text = book.title
		toggleReadBtn.setImage(readImg, for: .normal)
	}
}
