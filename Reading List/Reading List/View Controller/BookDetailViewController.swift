//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Welinkton on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    func updateViews()  {
        guard let book = book
            else {
                self.navigationItem.title = "Add a new book"
                
                return
        }
        
        bookTitleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
        self.navigationItem.title = book.title
    
    }
    

  
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    @IBAction func saveBookDetail(_ sender: Any) {
        guard let bookTitle = bookTitleTextField.text,
            let reasonToRead = reasonToReadTextView.text else {return}
        
        if book == nil {
            bookController?.createBook(withName: bookTitle , reasonToRead: reasonToRead)
            
        } else {
           
            guard let book = book else {return}
            
            bookController?.updateBookDetails(book: book, title: bookTitle, reasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    var bookController: BookController?
    var book: Book?
    
    
}

