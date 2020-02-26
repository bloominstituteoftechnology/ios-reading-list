//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Mark Gerrior on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        // In the action of the button, it should either call the createBook method in the bookController if the book property is nil or call the update method in the bookController if the book property is not nil.
        
        guard let bookTitle = titleTextField.text,
            let reasonToRead = reasonToReadTextView.text else { return }
        
        if book == nil {
            // Create book
            bookController?.create(title: bookTitle, reasonToRead: reasonToRead)
        } else {
            // Book exists, update it.
            bookController?.updateTitleAndReason(book: book!,
                                         title: bookTitle,
                                         reasonToRead: reasonToRead)
        }
        
        // Use this if you present modally
        //dismiss(animated: true, completion: nil)
        
        // Use this if you Show
        // TODO: Should I call it here or should the caller do it?
        navigationController?.popViewController(animated: true)
    }

    func updateViews() {
        guard let book = book else {
            self.title = "Add a new book"
            reasonToReadTextView.text = ""
            return
        }

        self.title = "Edit \(book.title)"

        if book.title == "" {
            self.title = "Enter a Title"
        }

        // Handle a saved blank title.
        titleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
    }
}
