//
//  ViewController.swift
//  Reading List
//
//  Created by Spencer Curtis on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if book == nil {
            bookController?.createBook(title: textField.text!, reasonToRead: textView.text, hasBeenRead: false)
        } else {
            book?.title = textField.text!
            book?.reasonToRead = textView.text!
            bookController?.updateBook(for: book!)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    var bookController: BookController?
    var book: Book?

    func updateViews() {
        if let book = book {
            textField.text = book.title
            textView.text = book.reasonToRead
            navigationItem.title = book.title
        } else {
            navigationItem.title = "Add a new book"
        }
    }
    
}

