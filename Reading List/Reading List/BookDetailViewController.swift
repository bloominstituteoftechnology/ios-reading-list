//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by David Williams on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitleLabel: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!
    
    var bookcontroller: BookController?
    var book: Book?
    var delegate: handleBookDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        reasonToReadTextField.text = book.reasonToRead
        // check to see if an existing book or a new book for title change
        if bookTitleLabel.text != nil {
            title = book.title
        } else if bookTitleLabel.text == "" {
            title = "Add a book"
        }
    }
   

    @IBAction func saveBookTapped(_ sender: Any) {
        guard let title = bookTitleLabel.text,
            let reason = reasonToReadTextField.text,
            !title.isEmpty,
            !reason.isEmpty else { return }
        if let book = book {
            bookcontroller?.editBook(book: book, title, reason: reason)
        } else {
            bookcontroller?.createBook(named: title, reasonToRead: reason, hasBeenRead: false)
        }
        navigationController?.popViewController(animated: true)
    }
}
