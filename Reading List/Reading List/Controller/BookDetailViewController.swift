//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Chad Rutherford on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var bookController: BookController?
    var book: Book?
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Set-Up
    private func updateViews() {
        if let book = book {
            titleTextField.text = book.name
            reasonTextView.text = book.reasonToRead
            title = book.name
        } else {
            title = "Add a new book"
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Actions
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        if let title = titleTextField.text, !title.isEmpty, let reason = reasonTextView.text, !reason.isEmpty {
            if let book = book {
                bookController?.update(name: title, reasonToRead: reason, for: book)
            } else {
                bookController?.create(with: title, reason: reason)
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
