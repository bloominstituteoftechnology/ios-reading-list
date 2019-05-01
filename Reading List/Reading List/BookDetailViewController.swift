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
	@IBOutlet var bookCoverImageView: UIImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateViews()
	}

	func updateViews() {
		navigationItem.title = "Add a new book"
		guard let book = book, isViewLoaded else { return }
		navigationItem.title = book.title
		bookTitleTextField.text = book.title
		reasonToReadTextView.text = book.reasonToRead
		if book.image != nil {
			bookCoverImageView.image = book.image
		}
	}

	@IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
		if let book = book {
			bookController?.update(title: bookTitleTextField.text, reasonToRead: reasonToReadTextView.text, image: bookCoverImageView.image, forBook: book)
		} else {
			guard let title = bookTitleTextField.text, let reason = reasonToReadTextView.text else { return }
			bookController?.createBook(titled: title, because: reason, image: bookCoverImageView.image)
		}
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func loadImageButtonPressed(_ sender: UIButton) {
		let picker = UIImagePickerController()
		picker.sourceType = .photoLibrary
		picker.delegate = self
//		picker.allowsEditing = true
		present(picker, animated: true)
	}
	
}

extension BookDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let importImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { print("import failed"); return}
		dismiss(animated: true)
		
		if book != nil {
			book?.image = importImage
			updateViews()
		} else {
			bookCoverImageView.image = importImage
		}

//		print(importImage)
//		print(bookCoverImageView)
//		print(bookCoverImageView.image)

	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true)
	}
}
