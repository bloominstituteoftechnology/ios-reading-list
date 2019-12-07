//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Dennis Rudolph on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var reasonText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(sender: UIBarButtonItem!) {
        if let book = book {
            guard let titleReady = titleText.text, let reasonReady = reasonText.text else { return }
            bookController?.edit(book: book, title: titleReady, reasonToRead: reasonReady)
            
        } else {
            guard let titleReady = titleText.text, let reasonReady = reasonText.text else { return }
            bookController?.create(bookTitle: titleReady, reasonToRead: reasonReady)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if let book = book {
            titleText.text = book.title
            reasonText.text = book.reasonToRead
            self.title = book.title
        } else {
            self.title = "Add a new book"
        }
        
    }


}
