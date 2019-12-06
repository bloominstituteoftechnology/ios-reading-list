//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jeremy Taylor on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        titleTextField.becomeFirstResponder()
    }
    
    @IBAction func saveBook(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text,
            let reasonToRead = reasonToReadTextView.text,
            !title.isEmpty,
            !reasonToRead.isEmpty else { return }
        
        if let book = book {
            // Update an existing book
            bookController?.updateBook(book, withTitle: title, andReasonToRead: reasonToRead)
            navigationController?.popViewController(animated: true)
        } else {
            // Create a new book
            bookController?.createBook(withTitle: title, andReasonToRead: reasonToRead)
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func updateViews() {
        guard isViewLoaded,
            let book = book else {
                title = "Add a new book"
                return
        }
        title = book.title
        titleTextField.text = book.title
        reasonToReadTextView.text = "\(book.reasonToRead)"
    }
}
