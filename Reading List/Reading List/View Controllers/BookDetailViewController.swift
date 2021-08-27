//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Gerardo Hernandez on 8/27/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    
    // MARK: - Properties
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let book = book {
            bookController?.updateBook(for: book, title: bookTitleTextField.text, reasonToRead: reasonToReadTextView.text)
        } else {
            if let title = bookTitleTextField.text,
               let reason = reasonToReadTextView.text, !title.isEmpty {
                bookController?.createBook(titled: title, reasonToRead: reason)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        if let book = book {
            bookTitleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
            self.title = book.title
        } else {
            self.title = "Add a new book"
        }
    }

}
