//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Welinkton on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
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
        guard let _ = bookTitleTextField.text,
            let reasonToRead = reasonToReadTextView.text
            
            else {return}
        
        if book == nil {
            bookController?.createBook(withName: title! , reasonToRead: reasonToRead)
        } else {
            guard let book = book else {return}
            
            bookController?.updateBookDetails(book: book, title: title!, reasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }
    

    
}

