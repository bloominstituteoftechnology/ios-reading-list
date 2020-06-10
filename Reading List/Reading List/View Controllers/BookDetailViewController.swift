//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by John McCants on 6/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
     var bookController: BookController?
     var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    func updateView() {
        if let book = book {
            titleTextField.text = book.title
            descriptionTextView.text = book.reasonToRead
            title = book.title
        } else {
            title = "Add a new book"
        }
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let title = titleTextField.text,
            let description = descriptionTextView.text,
            title != "" && description != "" else { navigationController?.popViewController(animated: true);return }
        
        if let book = book {
            bookController?.updateBookData(for: book, title: title, reasonToRead: description)
        } else {
            bookController?.createBook(title: title, reasonToRead: description)
        }
        
        navigationController?.popViewController(animated: true)
        
    }

}
