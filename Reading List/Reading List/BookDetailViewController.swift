//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Taylor Lyles on 5/7/19.
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
    
	@IBAction func saveButton(_ sender: UIBarButtonItem) {
		guard let tile = textField.text,
			let reasonToRead = textView.text else { return }
		if book == nil {
			bookController?.create(title: title!, reasonToRead: reasonToRead)
		} else {
			if let book = book {
				bookController?.updatedTitleAndOrReasonToRead(book: book, title: title!, reasonToRead: reasonToRead)
			}
			
		}
		navigationController?.popViewController(animated: true)
	}
	
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var textField: UITextField!
	
}
