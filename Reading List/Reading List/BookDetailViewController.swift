//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jonathan Ferrer on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    func updateViews() {
        guard let book = book else {
            self.navigationItem.title = "Add a new Book"
            return
        }
        bookTitleTextField.text = book.title
        reasontoReadTextView.text = book.reasonToRead
        self.navigationItem.title = book.title
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let bookTitle = bookTitleTextField.text,
        !bookTitle.isEmpty,
        let reasonToRead = reasontoReadTextView.text,
        !reasonToRead.isEmpty else { return }

        if let book = book {
            bookController?.updateBook(for: book, withTitle: bookTitle, reasonToRead: reasonToRead)
        } else {
            bookController?.createBook(title: bookTitle, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasontoReadTextView: UITextView!
    
}
