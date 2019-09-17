//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Gi Pyo Kim on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        if let book = book {
            bookTitleTextField.text = book.title
            reasonToReadTextView.text += " " + book.reasonToRead
            navigationItem.title = book.title
        } else {
            navigationItem.title = "Add a new book"
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let bookController = bookController,
                let title = bookTitleTextField.text, !title.isEmpty,
                let reasonToRead = reasonToReadTextView.text, !reasonToRead.isEmpty else { return }
        
        if let book = book {
            bookController.updateBook(book: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController.create(title: title, reasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }

}
