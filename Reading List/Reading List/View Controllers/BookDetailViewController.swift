//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Nathanael Youngren on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text else { return }
        
        if book == nil {
            bookController?.createBook(title: title, reasonToRead: reasonTextView.text)
            navigationController?.popViewController(animated: true)
        } else {
            bookController?.updateTitleReasonToRead(for: book!, title: title, reasonToRead: reasonTextView.text)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        guard let unwrappedBook = book else { return }
        
        titleTextField.text = unwrappedBook.title
        reasonTextView.text = unwrappedBook.reasonToRead
        
        if unwrappedBook.title != "" {
            navigationItem.title = unwrappedBook.title
        } else {
            navigationItem.title = "Add a new book"
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
}
