//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Kobe McKee on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    var book: Book?
    
 
    func updateViews() {
        if let book = book {
            TitleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
            
            navigationItem.title = book.title
        } else { navigationItem.title = "Add a new book"}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    
    
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let title = TitleTextField.text,
            let reasonToRead = reasonTextView.text
        else { return }
        
        print(reasonToRead)

        
        if let book = book {
            print(book.title)
            bookController?.updateBook(for: book, title: title, reasonToRead: reasonToRead)
            navigationController?.popViewController(animated: true)
            print("Attempting to update book")
        } else {
            bookController?.createBook(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
            print("Attempting to create new book")
            navigationController?.popViewController(animated: true)
        }
    }
    
}
