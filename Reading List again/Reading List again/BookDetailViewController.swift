//
//  BookDetailViewController.swift
//  Reading List again
//
//  Created by Nathanael Youngren on 1/17/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text else { return }
        
        if book == nil {
            bookController?.createBook(title: title, reason: reasonTextView.text)
            navigationController?.popViewController(animated: true)
        } else {
            bookController?.updateTitleReason(for: book!, title: title, reason: reasonTextView.text)
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
