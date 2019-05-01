//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Hector Steven on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		setupviews()
    }
	
	@IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
		guard let book = book  else { return }
		
		if saveEdittitle == "Edit" {
			if let title = bookTitleTextField.text {
				bookController?.upDateBookInfo(book: book, title: title, reasonToRead: nil)
			}
			if let reasonToRead = reasonToReadTextView.text {
				bookController?.upDateBookInfo(book: book, title: nil, reasonToRead: reasonToRead)
			}
			
		} else if saveEdittitle == "Save" {
			let title = bookTitleTextField.text ?? ""
			let reasonToRead = reasonToReadTextView.text ?? ""
			bookController?.creatBook(title: title, reasonToRead: reasonToRead)
		}
	}
	
	func setupviews(){
		guard let book = book else { return }
		bookTitleTextField?.text = book.title
		reasonToReadTextView?.text = book.reasonToRead
		saveEditButton.title = saveEdittitle
	}
	
	@IBOutlet var saveEditButton: UIBarButtonItem!
	@IBOutlet var bookTitleTextField: UITextField!
	@IBOutlet var reasonToReadTextView: UITextView!
	var book: Book? {
		didSet {
			setupviews()
		}
	}
	
	var saveEdittitle: String?
	var bookController: BookController?
}
