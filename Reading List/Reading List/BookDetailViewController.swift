//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Moses Robinson on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let title = nameTextField.text, !title.isEmpty,
        let reasonToRead = reasonTextView.text, !reasonToRead.isEmpty,
        let book = book else { return }
        
        if book.title.isEmpty {
            bookController?.createBook(title: title, reasonToRead: reasonToRead)
        } else {
            bookController?.updateBook(book: book, title: title, reasonToRead: reasonToRead)
        }
        
    }
    
    private func updateViews() {
        guard let book = book else { return }
        
        title = book.title
        nameTextField.text = book.title
        reasonTextView.text = book.reasonToRead
        
        if book.title.isEmpty {
            title = "Add a New Book"
        }
    }
    
    //MARK: - Properties
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
}
