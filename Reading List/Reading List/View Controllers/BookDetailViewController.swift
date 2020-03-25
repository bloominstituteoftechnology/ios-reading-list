//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Mark Poggi on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

// As stated before, the `BookDetailViewController` will function as a way to create a new `Book` or to view/update an existing one, depending on the segue that is triggered.

class BookDetailViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //  In the action of the button, it should either call the `createBook` method in the `bookController` if the `book` property is `nil` or call the `update` method in the `bookController` if the `book` property is not nil.
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text,
            let reasonToRead = reasonToReadTextView.text,
            title != "" && reasonToRead != "" else { return }
        
        if let book = book {
            bookController?.update(book: book, withTitle: title, reasonToRead: reasonToRead)
        } else {
            bookController?.createBook(name: title, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // Create an `updateViews()` method. If the `book` variable has a value, it should take its `title` and put it in the text field, and put its `reasonToRead` in the textView. It should also set the title of the view controller to the `book`'s title if there is one, or it should set the title to "Add a new book" if a new book is going to be created.
    
    func updateViews() {
        
        guard let book = book else {
            title = "Add a new book"
            return }
        
        title = book.title
        titleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
    }
    
    // Add a `var bookController: BookController?` variable. Whether the user is creating a new `Book` or updating an existing one, this view controller will need access to the `BookController` to do so.
    
    var bookController: BookController?
    
    //Add a `var book: Book?` variable. This is going to be nil if the user taps on the plus button to create a new `Book`, or it will actually hold a `Book` object if they are trying to view/update one by segueing when tapping on a cell in the table view.
    
    var book: Book?
    
    //Be sure that you've added outlets to the text field and text view, and the action from the save button if you haven't done so.
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
}
