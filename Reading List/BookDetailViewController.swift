//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by LaFleur on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit


class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookNameTextField: UITextField!
        
    @IBOutlet weak var reasonToReadTextField: UITextView!
    
    
    var book: Book?
    var bookController: BookController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let book = book else { return }
        bookNameTextField.text = book.title
        reasonToReadTextField.text = book.reasonToRead
    }
    
   
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
            
            guard let bookName = bookNameTextField.text,
                bookName != "",
                let reasonToRead = reasonToReadTextField.text,
                reasonToRead != "" else { return }
        
        if let book = book {
            bookController?.update(which: book, bookName, reasonToRead)
        } else {
            bookController?.createBook(titled: bookName, withReasonToRead: reasonToRead)
        }
            navigationController?.popViewController(animated: true)

    }
}

