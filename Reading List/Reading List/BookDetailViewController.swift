//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jeffrey Carpenter on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let title = bookTitleTextField.text,
        !title.isEmpty,
        let reason = reasonTextView.text,
        !reason.isEmpty
        else { return }
        
        if let book = book {
            bookController?.updateBook(book, newTitle: title, newReason: reason)
        } else {
            bookController?.createBook(titled: title, withReason: reason)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        
        if let book = book  {
            self.navigationItem.title = book.title
            bookTitleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
        } else {
            self.navigationItem.title = "Add a new book"
            reasonTextView.text = "Reason to read: "
        }
        
        
    }
}
