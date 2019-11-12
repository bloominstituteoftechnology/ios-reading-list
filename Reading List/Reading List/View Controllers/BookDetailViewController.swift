//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Alexander Supe on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var titleOut: UITextField!
    @IBOutlet weak var reasonToReadOut: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    func updateViews() {
        if book != nil {
            titleOut.text = book?.title
            reasonToReadOut.text = book?.reasonToRead
            title = book?.title
        } else {
            title = "Add a new book"
        }
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        if titleOut.text != "" {
            if book != nil {
                bookController?.editBook(for: book!, title: titleOut.text!, reasonToRead: reasonToReadOut.text)
            } else {
                bookController?.createBook(title: titleOut.text!, reasonToRead: reasonToReadOut.text)
            }
        } else {
            print("Empty input")
        }
        
    }
    
}
