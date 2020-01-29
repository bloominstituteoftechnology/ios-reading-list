//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by beth on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
     @IBOutlet weak var textField: UITextView!

     var bookController: BookController?
     var book: Book?

        
        override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
         if (book == nil) {
             self.title = "Add a new book"
         } else {
             self.title = book?.title
             titleTextField.text = book?.title
             textField.text = book?.reasonToRead
         }
     }
    
   @IBAction func saveButton(_ sender: Any) {
            if let book = book {
                guard let titleReady = titleTextField.text, let reasonReady = textField.text else { return }
                bookController?.editBook(book: book, title: titleReady, reasonToRead: reasonReady)
                        } else {
                guard let titleReady = titleTextField.text, let reasonReady = textField.text else { return }
                bookController?.createBook(named: titleReady, withReason: reasonReady)
                }
            navigationController?.popViewController(animated: true)
        }

}
