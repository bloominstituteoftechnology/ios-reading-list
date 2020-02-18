//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Spencer Curtis on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var bookTitleText: UITextField!
    @IBOutlet weak var bookDetailText: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad () {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK IBActions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = bookTitleText.text, let reason = bookDetailText.text else { return }
        if let book = book {
            bookController?.editBook(book: book, title: title)
        } else {
            bookController?.createBook(title: title, reasonToRead: reason)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if book != nil {
            self.title = book?.title
            bookTitleText.text = book?.title
            bookDetailText.text = book?.reasonToRead
        } else {
            self.title = "Add a new book"
        }
    }

}

