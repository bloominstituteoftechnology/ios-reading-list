//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Bronson Mullens on 4/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add a book"
        updateViews()
    }
    
    // IBOutlets
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonsToReadTextView: UITextView!
    
    
    // IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = bookTitleTextField.text,
            let reasonToRead = reasonsToReadTextView.text,
            !title.isEmpty,
            !reasonToRead.isEmpty else { return }
        
        if let book = book {
            bookController?.updateBookInfo(for: book, newTitle: title, newReasonToRead: reasonToRead)
        } else {
            bookController?.createBook(bookTitle: title, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }

    var bookController: BookController?
    
    var book: Book?
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleTextField.text = book.title
        reasonsToReadTextView.text = book.reasonToRead
        title = book.title
    }

}
