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
    
    var book: Book?

    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        guard let title = textField.text, let reasonToRead = textView.text else { return }
        
        if book == nil {
            bookController?.createBook(withTitle: title, reasonToRead: reasonToRead, hasBeenRead: false)
        } else {
            updateViews()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if let book = book {
            textField.text = book.title
            textView.text = book.reasonToRead
            navigationController?.title = book.title
        } else {
            navigationController?.title = "Add a new book"
        }
    }

}
