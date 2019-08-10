//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by John Kouris on 8/10/19.
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
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let bookTitleText = bookTitleTextField.text,
            let reasonToReadText = reasonToReadTextView.text,
            !bookTitleText.isEmpty,
            !reasonToReadText.isEmpty else { return }
        
        if book == nil {
            bookController?.createBook(withTitle: bookTitleText, reasonToRead: reasonToReadText)
        } else {
            if let book = book {
                bookController?.updateBookDetails(for: book, title: bookTitleText, reasonToRead: reasonToReadText)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if let book = book {
            bookTitleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
            title = book.title
        } else {
            title = "Add a new book"
        }
    }
    
}
