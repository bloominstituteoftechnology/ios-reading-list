//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Dennis on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookReasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveBarButtonTapped(_ sender: UIBarButtonItem) {
        if let book = book {
            bookController?.editBook(book: book, newTitle: book.title, newReason: book.reasonToRead)
        } else {
            if let createdTitle = bookTitleTextField.text, let createdReason = bookReasonTextView.text  {
            bookController?.createBook(title: createdTitle, reasonToRead: createdReason)
        }
    }
}
    
    func updateViews() {
        if let book = book {
            bookTitleTextField.text = book.title
            bookReasonTextView.text = book.reasonToRead
            
            self.title = book.title
        } else {
            self.title = "Add a new book"
        }
    }
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


