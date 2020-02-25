//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Shawn Gee on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    
    var bookController: BookController?
    var book: Book?
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let bookController = bookController else { return }
        guard let title = titleTextField.text,
              let reasonToRead = reasonToReadTextView.text else {
            print("We should inform the user that a title and reason are needed")
            return
        }
        
        if let book = book {
            bookController.update(book: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController.createBook(withTitle: title, reasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if let book = book {
            titleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
            navigationItem.title = book.title
        }
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

}
