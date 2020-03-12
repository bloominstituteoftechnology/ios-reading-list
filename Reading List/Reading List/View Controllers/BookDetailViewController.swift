//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Spencer Curtis on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!

    var bookController: BookController?
    var book: Book?
    var delegate: BookDetailDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func updateViews() {
        if let book = book {
            titleTextField.text = book.title
            reasonToReadTextField.text = book.reasonToRead
            title = book.title
        } else {
            title = "Add a new book"
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard
            let newTitle = titleTextField.text,
            let newReasonToRead = reasonToReadTextField.text else { return }
        if let book = book {
            bookController?.update(book, title: newTitle, reasonToRead: newReasonToRead)
        } else {
            bookController?.create(title: newTitle, reasonToRead: newReasonToRead)
        }
        delegate?.bookHasBeenUpdated()
        navigationController?.popViewController(animated: true)
    }
}
