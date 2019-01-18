//
//  BookDetailViewController.swift
//  Reading List again
//
//  Created by Nathanael Youngren on 1/17/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book? {
        didSet { updateViews() }
    }
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    
    @IBAction func saveBarButtonTapped(_ sender: Any) {
        guard let bookController = bookController,
            let title = bookTitleTextField.text, !title.isEmpty,
            let reason = reasonToReadTextView.text else { return }
        
        if let book = book {
            bookController.update(book: book, title: title, reasonToRead: reason)
        } else {
            bookController.createBook(with: title, reasonToRead: reason)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        if let book = book {
            bookTitleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
            navigationItem.title = book.title
        } else {
            navigationItem.title = "Add a new book"
        }
    }
}
