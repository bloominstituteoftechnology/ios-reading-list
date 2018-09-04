//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Dillon McElhinney on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    // MARK: - Properties
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    // MARK: - UI Methods
    @IBAction func saveBook(_ sender: UIBarButtonItem) {
        //Unwrap the text fields and views and make sure the required ones have content.
        guard let title = titleTextField.text, !title.isEmpty,
            let reasonToRead = reasonToReadTextField.text else { return }
        
        if let book = book {
            //Update the current book
            bookController?.update(book, title: title, reasonToRead: reasonToRead, imageData: nil)
        } else {
            //Create a new book
            bookController?.createBook(title: title, reasonToRead: reasonToRead, imageData: nil)
        }
        
        //Pop the view off of the stack
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Utility Methods
    private func updateViews() {
        //If there is no book, the user is adding a new one
        guard let book = book else {
            title = "Add a new book"
            return
        }
        
        //If there is a book, update the UI to reflect its properties
        title = book.title
        titleTextField.text = book.title
        reasonToReadTextField.text = book.reasonToRead
    }
    
}
