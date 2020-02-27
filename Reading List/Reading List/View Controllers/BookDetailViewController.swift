//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Harmony Radley on 2/25/20.
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
        // Do any additional setup after loading the view.
    }
 

    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let bookTitle = bookTitleTextField.text,
            let reasonToRead = reasonToReadTextView.text,
            !bookTitle.isEmpty,
            !reasonToRead.isEmpty else { return }
        if let book = book {
            bookController?.updateTitle(book: book, title: bookTitle, reasonToRead: reasonToRead)
        } else {
            bookController?.createABook(with: bookTitle, reasonToRead: reasonToRead)
            
        }
        navigationController?.popViewController(animated: true)
            
        
    }
    
    
    


    func updateViews() {
        if let book = book {
            title = book.title
            bookTitleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
        }
    }
    
  

}

