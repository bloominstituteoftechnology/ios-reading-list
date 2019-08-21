//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by brian vilchez on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    var book:Book? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var bookNameTextField:UITextField!
    @IBOutlet weak var reasonsTextView:UITextView!
    
    func updateViews() {
        guard let book = book else {return}
        bookNameTextField.text = book.title
        reasonsTextView.text = book.reasonToRead
    }
    
    @IBAction func saveButtonTapped(_ sender:UIButton) {
        guard let bookName = bookNameTextField.text, !bookName.isEmpty,
            let reasonToRead = reasonsTextView.text, !reasonToRead.isEmpty else {return}
        if book == nil {
            bookController?.addBook(withTitle: bookName, reasonToRead: reasonToRead)
            dismiss(animated: true, completion: nil)
        } else if book != nil {
            bookController?.updateBook(withTitle: bookName, reasonToRead: reasonToRead)
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reasonsTextView.text = "Reason To Read:"
    }
}
