//
//  ViewController.swift
//  ReadingListApp
//
//  Created by Nelson Gonzalez on 1/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateViews()
    }
    
    func updateViews() {
        if let book = book {
        bookTitleTextField.text = book.title
        descriptionTextView.text = book.reasonToRead
        self.title = book.title
        } else {
            self.title = "Add a new book"
        }
    }

    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let title = bookTitleTextField.text, !title.isEmpty, let description = descriptionTextView.text, !description.isEmpty else { return }
        if let book = book {
            bookController?.updateBook(for: book, with: title, reasonToRead: description)
        } else {
            bookController?.create(withBook: title, reasonToRead: description)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
}

