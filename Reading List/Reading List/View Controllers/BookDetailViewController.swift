//
//  BooksViewController.swift
//  Reading List
//
//  Created by Spencer Curtis on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
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
    
    
    
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let bookTitle = bookTitleTextField.text, !bookTitle.isEmpty,
            let reasonToRead = reasonToReadTextView.text, !reasonToRead.isEmpty else { return }
        
        if book == nil {
            bookController?.createBook(named: bookTitle, with: reasonToRead)
        } else {
            if let book = book {
                bookController?.updateBook(for: book, with: bookTitle, and: reasonToRead)
            }
        }
        
        navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    

    


}

