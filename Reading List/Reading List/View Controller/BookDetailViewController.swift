//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Ilgar Ilyasov on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book? {
        didSet { updateViews() }
    }
    
    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let theBook = book,
              let title = book?.title,
              let reason = book?.reasonToRead else { return }
        
        if book == nil {
            bookController?.createBook(title: title, reasonToRead: reason)
        } else {
            bookController?.modifyBook(book: theBook, tite: title, reasonToRead: reason)
        }
    }
    
    private func updateViews() {
        guard let title = book?.title,
              let reason = book?.reasonToRead else { return }
        
        bookTitleTextField.text = title
        reasonToReadTextView.text = reason
        
        if title != "" {
            self.navigationItem.title = title
        } else {
            self.navigationItem.title = "Add a new book"
        }
    }
}
