//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Donella Barcelo on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let book = book else {
            title = "Add a new book"
            return
        }
        titleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
        title = book.title
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let title = titleTextField.text,
            let reasonToRead = reasonToReadTextView.text {
            
            if book == nil {
                bookController?.createBook(title: title, reasonToRead: reasonToRead)
            } else {
                guard let book = book else { return }
                bookController?.updateBookInfo(for: book, newTitle: title, newReasonToRead: reasonToRead)
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
}
