//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Claudia Contreras on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var readTextView: UITextView!
    
    
    //MARK: - Properties
    var bookController: BookController?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add a new book"
        // updateViews()
        

    }
    //MARK: - Function
    private func updateViews() {
        loadViewIfNeeded()
        guard let book = book else { return }
        //Set the Text field
        titleTextField.text = book.title
        //Set the Text View
        readTextView.text = book.reasonToRead
        //Set the title
        title = book.title
    }
    
    
    //MARK: - IBAction
    @IBAction func saveTapped(_ sender: Any) {
        guard let bookController = bookController else { return }
        
        guard let title = titleTextField.text, !title.isEmpty,
        let reasonToRead = readTextView.text, !reasonToRead.isEmpty else { return }
        
        if let book = book {
            bookController.updateTitleOrReasonToRead(book: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController.createBook(title: title, reasonToRead: reasonToRead)
        }

        navigationController?.popViewController(animated: true)
    }
    
}
