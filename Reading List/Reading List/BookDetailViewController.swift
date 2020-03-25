//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Chris Dobek on 3/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           updateViews()
    }
    
    func updateViews() {
        if let book = book {
        bookTitleTextField.text = book.title
        reasonToReadTextField.text = book.reasonToRead
        self.title = book.title
        } else {
            self.title = "Add a new book"
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        guard let title = bookTitleTextField.text, !title.isEmpty, let description = reasonToReadTextField.text, !description.isEmpty else { return }
            if let book = book {
                
                bookController?.updateBook(for: book, title: title, reasonToRead: description)
            } else {
                bookController?.createBook(withBook: title, reasonToRead: description)
            }
            navigationController?.popViewController(animated: true)

        }
}
