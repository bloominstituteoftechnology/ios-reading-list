//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Enrique Gongora on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let title = bookTitleTextField.text, let reason = reasonToReadTextView.text else { return }
        if let book = book{
            bookController?.editBook(book: book, title: title)
        }else{
            bookController?.createBook(title: title, reasonToRead: reason)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
    func updateViews() {
        if book != nil {
            self.title = book?.title
            bookTitleTextField.text = book?.title
            reasonToReadTextView.text = book?.reasonToRead
        }else{
            self.title = "Add a new book"
        }
    }

}
