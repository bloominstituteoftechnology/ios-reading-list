//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Isaac Lyons on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController? {
        didSet {
            updateViews()
        }
    }
    var book: Book?
    
    func updateViews() {
        if let book: Book = book{
            print(book.title)
                    titleTextField.text = "test"
                    //reasonToReadTextView.text = book.reasonToRead
            navigationItem.title = book.title
        } else {
            navigationItem.title = "Add a new book"
        }
    }

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
    }
}
