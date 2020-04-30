//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Dawn Jones on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let title = titleTextField.text,
            let reason = reasonTextView.text,
            title != "" && reason != "" else { navigationController?.popViewController(animated: true);return }
        
        if let book = book {
            bookController?.updateBookData(for: book, title: title, reasonToRead: reason)
        } else {
            bookController?.createBook(title: title, reasonToRead: reason)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if let book = book {
            titleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
            title = book.title
        } else {
            title = "Add a new book"
        }
    }

}
