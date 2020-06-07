//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Norlan Tibanear on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.clipsToBounds = true
        
        updateView()
    }
    
    func updateView() {
        if let book = book {
            titleTextField.text = book.title
            descriptionTextView.text = book.reasonToRead
            title = book.title
        } else {
            title = "Add a new book"
        }
        
    }
    

    @IBAction func saveBtn_TouchUpInside(_ sender: UIBarButtonItem) {
        
        guard let title = titleTextField.text,
            let description = descriptionTextView.text,
            title != "" && description != "" else { navigationController?.popViewController(animated: true);return }
        
        if let book = book {
            bookController?.updateBookData(for: book, title: title, reasonToRead: description)
        } else {
            bookController?.createBook(title: title, reasonToRead: description)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    

} // END
