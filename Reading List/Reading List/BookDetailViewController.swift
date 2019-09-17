//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Isaac Lyons on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol BookDetailDelegate {
    func bookWasSaved()
}

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var book: Book?
    var bookController: BookController?
    var delegate: BookDetailDelegate?
    
    override func viewDidLoad() {
        updateViews()
    }
    
    func updateViews() {
        if let book = book {
            titleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
            navigationItem.title = book.title
        } else {
            navigationItem.title = "Add a new book"
        }
    }

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text,
            let reasonToRead = reasonToReadTextView.text,
            !title.isEmpty,
            !reasonToRead.isEmpty else { return }
        
        if let book = book {
            bookController?.updateBook(book: book, newTitle: title, newReasonToRead: reasonToRead)
        } else {
            bookController?.create(name: title, reasonToRead: reasonToRead)
        }
        delegate?.bookWasSaved()
    }
}
