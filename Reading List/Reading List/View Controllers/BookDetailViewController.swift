//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Linh Bouniol on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        guard let title = textField.text, let reasonToRead = textView.text else { return }
        
        if let book = book {
            bookController?.update(book: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController?.createBook(withTitle: title, reasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
//        guard let textField = textField, let textView = textView else { return }
        // USe guard, or just put ?
        
        if let book = book {
            textField?.text = book.title
            textView?.text = book.reasonToRead
            navigationController?.title = book.title
        } else {
            navigationController?.title = "Add a new book"
        }
    }

}
