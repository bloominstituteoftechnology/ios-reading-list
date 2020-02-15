//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Claudia Contreras on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bookTextView: UITextView!
    
    //MARK: - Properties
    var bookController = BookController()
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - Function
    func updateViews() {
        if book != nil {
            if let title = book?.title, !title.isEmpty,
                let reason = book?.reasonToRead, !reason.isEmpty {
                //Set the Text field
                titleTextField.text = title
                //Set the Text View
                bookTextView.text = reason
                //Set the title
                self.title = book?.title
            }
            //add New Title
            self.title = "Add a new book"
        }
        
    }
    
    
    //MARK: - IBAction
    @IBAction func saveTapped(_ sender: Any) {
        if let book = book {
            bookController.updateTitleOrReasonToRead(for: book)
        } else {
            if let title = titleTextField.text,
                let reasonToRead = bookTextView.text{
            
            bookController.createBook(title: title, reasonToRead: reasonToRead)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}
