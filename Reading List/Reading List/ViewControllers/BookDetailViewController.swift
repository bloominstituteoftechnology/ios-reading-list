//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Cora Jacobson on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    
    var book: Book?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let book = book {
            bookController?.editBook(book, titleTextField.text, reasonTextView.text)
        } else {
            if let title = titleTextField.text,
                let reason = reasonTextView.text,
                !title.isEmpty {
                bookController?.createBook(title, reason)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if let book = book {
            titleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
            self.title = book.title
        } else {
            self.title = "Add a new book"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

}
