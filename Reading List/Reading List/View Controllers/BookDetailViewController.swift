//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jordan Davis on 5/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let title = bookTitleTextField.text, !title.isEmpty,
            let reasonToRead = reasonTextView.text, !reasonToRead.isEmpty else { return }
        
        if let book = book {
            bookController?.updateBook(book: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController?.createBook(title: title, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let book = book else { return }
        
        title = book.title
        bookTitleTextField.text = book.title
        reasonTextView.text = book.reasonToRead
        
        if book.title.isEmpty {
            title = "Add a New Book"
        }
    }
    
    
    //MARK: -Properties
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet var bookTitleTextField: UITextField!
    @IBOutlet var reasonTextView: UITextView!
    
}
