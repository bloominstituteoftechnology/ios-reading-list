//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Brian Rouse on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    
    var book: Book? {
        didSet {
            if let _ = view {
                updateViews()
            }
            
        }
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let bookTitle      = bookTitleTextField.text,
            let reason         = reasonToReadTextView.text,
            let bookController = bookController else { return }
        bookController.createBook(named: bookTitle, reason: reason)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func updateViews() {
        
        guard let book = book else { return }
        
        bookTitleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
        self.title = title
    }
    
    
}
