//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by De MicheliStefano on 31.07.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Methods
    
    private func updateViews() {
        if let book = book {
            self.title = book.title
            bookTitleTextField?.text = book.title
            reasonToReadTextView?.text = book.reasonToRead
        } else {
            self.title = "Add a new book"
        }
    }
    
    @IBAction func save(_ sender: Any) {
        guard let title = bookTitleTextField.text,
            let reasonToRead = reasonToReadTextView.text else { return }
        
        if let book = book {
            bookController?.updateBook(for: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController?.create(title: title, reasonToRead: reasonToRead)
        }
        
        bookController?.loadFromPersistentStore()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Properties
    
    var bookController: BookController?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
}
