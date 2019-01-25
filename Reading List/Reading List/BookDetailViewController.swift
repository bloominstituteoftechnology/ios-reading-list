//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_59 on 1/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var bookController: BookController?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    @IBAction func save(_ sender: Any) {
        guard let title = textField.text,
            let reasonToRead = textView.text else { return }
        
        if let book = book {
            bookController?.update(book: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController?.createBook(withTitle: title, reasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func updateViews() {
        if let book = book {
            textField?.text = book.title
            textView?.text = book.reasonToRead
            navigationController?.title = book.title
        } else {
            navigationController?.title = "Add a new book"
        }
    }

}
