//
//  ManageBookVC.swift
//  Reading List
//
//  Created by Spencer Curtis on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

protocol ManageBookVCDelegate {
	func passBookDetails(existingBookIndex index: Int?, title: String, reasonRead reason: String)
}

class ManageBookVC: UIViewController {

	@IBOutlet weak var titleTextfield: UITextField!
	@IBOutlet weak var reasonTextView: UITextView!
	
	var delegate: ManageBookVCDelegate?
	var book: Book?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		updateViews()
    }

	@IBAction func saveBtnAction(_ sender: Any) {
		guard let title = titleTextfield.optionalText, let reason = reasonTextView.text else { return }
		
		delegate?.passBookDetails(existingBookIndex: book?.index, title: title, reasonRead: reason)
	}
	
	private func updateViews() {
		guard let book = book else { return }
		titleTextfield.text = book.title
		reasonTextView.text = book.reasonRead
	}
	
}

