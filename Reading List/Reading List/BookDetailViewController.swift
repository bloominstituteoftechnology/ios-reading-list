//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Daniela Parra on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func updateViews() {
        guard let book = book
            else {
                self.navigationItem.title = "Add a new book"
                return
        }
        
        self.navigationItem.title = book.title
        bookTextField.text = book.title
        reasonTextView.text = book.reasonToRead
    }
    
    
    @IBAction func saveBook(_ sender: Any) {
        guard let bookTitle = bookTextField.text,
            let reasonToRead = reasonTextView.text else { return }
        
        if book == nil {
            bookController?.create(title: bookTitle, reasonToRead: reasonToRead)
        } else {
            guard let book = book else {return}
            
            bookController?.update(book: book, title: bookTitle, reasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var bookTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var book: Book?
    var bookController: BookController?
}
