//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Zack Larsen on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var bookController: BookController?
    
    @IBOutlet weak var bookTextField: UITextField!
    @IBOutlet weak var bookTextView: UITextView!
    
    @IBAction func saveButton(_ sender: Any) {
        guard let updatedTitle = bookTextField.text,
        let updatedReason = bookTextView.text else { return }
        if let book = book {
            bookController?.updateReasonToRead(book: book, title: updatedTitle, reasonToRead: updatedReason)
        } else {
            bookController?.createBook(with: updatedTitle, reasonToRead: updatedReason)
        }
    }
    
    var book: Book? {
        didSet {
            
        }
    }
    
    func updateViews() {
        guard let book = book else { return }
    
        bookTextField.text = book.title
        bookTextView.text = book.reasonToRead
    }
    

}
