//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by James Sedlacek on 6/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    var book: Book?
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // either call the createBook method in the bookController
        // if the book property is nil
        
        if let theBook = book {
            bookController?.updateBook(book: theBook,
                                       newBookTitle: bookTitleTextField.text ?? nil,
                                       newReasonToRead: reasonToReadTextView.text ?? nil)
        } else {
            // or call the update method in the bookController
            // if the book property is not nil.
            bookController?.createBook(title: bookTitleTextField.text ?? "", reasonToRead: reasonToReadTextView.text ?? "")
        }
        
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        //If the book variable has a value,
        if let theBook = book {
        //it should take its title and put it in the text field,
            bookTitleTextField.text = theBook.title
        //and put its reasonToRead in the textView.
            reasonToReadTextView.text = theBook.reasonToRead
        //It should also set the title of the view controller to the book's title if there is one
            self.title = theBook.title
        } else {
            //or it should set the title to "Add a new book"
            //if a new book is going to be created.
            self.title = "Add a New Book"
            bookTitleTextField.placeholder = "Book Title"
            reasonToReadTextView.text = "Reason to read: "
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    

}
