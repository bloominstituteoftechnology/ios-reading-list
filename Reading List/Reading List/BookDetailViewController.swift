//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Spencer Curtis on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController, BookControllerProtocol {
	
	var bookController: BookController?
	var book: Book? {
		didSet {
			updateViews()
		}
	}
	
	@IBOutlet var bookTitleTextField: UITextField!
	@IBOutlet var reasonToReadTextView: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

	func updateViews() {
		navigationItem.title = "Add a new book"
		guard let book = book else { return }
		navigationItem.title = book.title
		bookTitleTextField.text = book.title
		reasonToReadTextView.text = book.reasonToRead
	}

	@IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
		if let book = book {
			bookController?.update(title: bookTitleTextField.text, reasonToRead: reasonToReadTextView.text, forBook: book)
		} else {
			guard let title = bookTitleTextField.text, let reason = reasonToReadTextView.text else { return }
			bookController?.createBook(titled: title, because: reason)
		}
		navigationController?.popViewController(animated: true)
	}
	
}

