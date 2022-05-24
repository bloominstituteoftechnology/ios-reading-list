//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Waseem Idelbi on 5/23/22.
//  Copyright © 2022 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
//MARK: - Properties
    var bookController: BookController?
    var book: Book?

//MARK: - IBOutlets
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonsToReadTextView: UITextView!
    
//MARK: - Methods
    func updateViews() {
        if let book = book {
            title = book.title
            bookTitleTextField.text = book.title
            reasonsToReadTextView.text = book.reasonToRead
        } else {
            title = "Add a new book"
        }
    }
    
//MARK: - IBActions
    @IBAction func SaveButtonTapped(_ sender: Any) {
        guard let newTitle = bookTitleTextField.text,
              let newReason = reasonsToReadTextView.text,
              !bookTitleTextField.text!.isEmpty,
              !reasonsToReadTextView.text.isEmpty else { return }
        
        if var book = book {
            bookController?.updateBook(book: &book, newTitle: newTitle, newReasonToRead: newReason)
        } else {
            bookController?.newBook(title: newTitle, reasonToRead: newReason)
        }
        
        dismiss(animated: true)
    }
    
}
