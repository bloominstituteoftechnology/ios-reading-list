//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Victor  on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var bookTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let book = book else {return}
        bookTextField.text = book.title
        textView.text = book.reasonToRead
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        //handle when save button is pressed
        if book == nil {
            guard let title = bookTextField.text, let reasonToRead = textView.text else {return}
            bookController?.addBook(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
            print("book created")
        } else {
            guard let book = book, let title = bookTextField.text, let reasonToRead = textView.text else {return}
            bookController?.updateBookDetails(for: book, reasonToRead: reasonToRead, title: title)
            bookController?.saveToPersistenceStore()
        }
    }
}
