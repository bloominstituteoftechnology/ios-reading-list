//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Shawn Gee on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet private var titleTextField: UITextField! {
        didSet {
            titleTextField.delegate = self
        }
    }
    @IBOutlet private var reasonToReadTextView: UITextView!
    @IBOutlet private var saveButton: UIBarButtonItem!
    
    // MARK: - Public Properties
    
    var bookController: BookController?
    var book: Book?
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let bookController = bookController,
              let title = titleTextField.text,
              let reasonToRead = reasonToReadTextView.text else { return }
        
        if let book = book {
            bookController.update(book: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController.createBook(withTitle: title, reasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Private Methods
    
    private func updateViews() {
        if let book = book {
            titleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
            navigationItem.title = book.title
        }
        updateSaveButton()
    }
    
    private func updateSaveButton() {
        guard let titleText = titleTextField.text else { return }
        saveButton.isEnabled = !titleText.isEmpty
    }
}

// MARK: - Text Field Delegate

extension BookDetailViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateSaveButton()
    }
}
