//
//  BookDetailViewController.swift
//  ReadTheList Project
//
//  Created by Michael Flowers on 1/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book? { //this is going to be nil if the user taps on the plus button to create a new book.
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        //check to see if there's text
        guard let title = textfield.text, !title.isEmpty, let reason = textView.text, !reason.isEmpty else { return }
        
        //now that we have the text information we can either update or create a model object. Check to see if there was one already passed in.
         guard let passedInBook = book else {
            
            //there was no book passed in so we call the create book function
            bookController?.createBook(with: title, reasonToRead: reason)
            navigationController?.popToRootViewController(animated: true)
            return }
        
            //there's a book already so we will call the update method
            bookController?.updateBook(book: passedInBook, newTitle: title, newReasonToRead: reason)
            navigationController?.popToRootViewController(animated: true)
    }
    
    func updateViews(){
        guard let passedInBook = book else {
             navigationController?.title = "Add New Book"
            return }
        textfield.text = passedInBook.title
        textView.text = passedInBook.reasonToRead
         navigationController?.title = "Update Book"
    }

}
