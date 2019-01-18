//
//  ViewController.swift
//  ReadingList
//
//  Created by Jocelyn Stuart on 1/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var bookController: BookController?
    
    var book: Book?

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var reasonTextView: UITextView!
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let bookTitle = titleTextField.text, !bookTitle.isEmpty,
            let reason = reasonTextView.text else {return}
        
        if let book = book {
            bookController?.update(book: book, title: bookTitle, reason: reason)
           // navigationItem.title = "Update book"
        
        } else {
            bookController?.createBook(withTitle: bookTitle, andReason: reason)
           // navigationItem.title = "Add a book"
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
      //  guard let bookTitle = titleTextField.text else { return }
        
        if let book = book { //!bookTitle.isEmpty
            titleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
            
            navigationItem.title = titleTextField.text
            
        } else {
            navigationItem.title = "Add a New Book"
        }
        
    }
    
    
}

