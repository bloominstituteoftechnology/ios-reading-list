//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Clayton Watkins on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews(){
        guard let book = book else { return }
        self.bookTitleTextField.text = book.title
        self.reasonToReadTextView.text = book.reasonToRead
        self.navigationItem.title = book.title
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let book = book{
            guard let title = bookTitleTextField.text,
                let reason = reasonToReadTextView.text else { return}
            bookController?.updateBook(for: book, title: title, reasonToRead: reason)
            navigationController?.popViewController(animated: true)
        } else{
            guard let title = bookTitleTextField.text,
                let reason = reasonToReadTextView.text else { return }
            bookController?.createBook(name: title, reasonToRead: reason)
            navigationController?.popViewController(animated: true)
        }
    }
}
