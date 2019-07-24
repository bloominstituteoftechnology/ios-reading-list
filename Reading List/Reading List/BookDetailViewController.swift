//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Taylor Lyles on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController, BookControllerProtocol {
	
	var bookController: BookController?
	var book: Book? {
		didSet {
			updateViews()
		}
	}
	
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var textView: UITextView!
	
	@IBAction func saveButton(_ sender: UIButton) {
		guard let title = textField.text,
			let reasonToRead = textView.text else { return } 
		if book == nil {
			bookController?.create(withTitle: title, reasonToBeRead: reasonToRead)
		} else {
			if let book = book {
				bookController?.titleAndReasonToRead(book: book, title: title, reasonToRead: reasonToRead)
			}
			
		}
		navigationController?.popViewController(animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		updateViews()
		
	}
	
	private func updateViews() {
		guard let book = book, isViewLoaded else { return}
		
		title = book.title
		textField.text = book.title
		textView.text = book.reasonToRead
	}

	

}
