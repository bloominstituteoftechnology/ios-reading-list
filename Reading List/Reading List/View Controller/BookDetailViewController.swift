//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Ilgar Ilyasov on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = bookTitleTextField.text,
              let reason = reasonToReadTextView.text,
              title != "" && reason != "" else { return } // Why we use a conditional statement like this?
        
        if let theBook = book {
            bookController?.modifyBook(book: theBook, tite: title, reasonToRead: reason)
        } else {
            bookController?.createBook(title: title, reasonToRead: reason)
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func updateViews() {
        guard let title = bookTitleTextField.text,
              let reason = reasonToReadTextView.text else { return }
        
        if title != "" {
            book?.title = title
            book?.reasonToRead = reason
            self.navigationItem.title = title
        } else {
            self.navigationItem.title = "Add a new book"
        }
    }
}
