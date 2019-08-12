//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Casualty on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookTitle: UITextField!
    
    @IBOutlet weak var reasonTextField: UITextView!
    
    var bookController: BookController?
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // updating views
        bookTitle.delegate = self
        updateViews()
    }

    @IBAction func saveTapped(_ sender: Any) {
        guard let title = bookTitle.text, let reason = reasonTextField.text else { return }
        
        if let currentBook = book {
            self.book = bookController?.updateBook(for: currentBook, bookTitle: title, bookReason: reason)
        } else {
            self.book = bookController?.addBook(named: title, reason: reason)
            bookTitle.becomeFirstResponder()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if let newBook = book {
            bookTitle.text = newBook.title
            title = bookTitle.text
            reasonTextField.text = newBook.reasonToRead
        } else {
            title = "Add new book"
        }
    }
}

extension BookDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else {
            return false
        }
        if textField == bookTitle {
            reasonTextField.becomeFirstResponder()
        }
        return true
    }
}
