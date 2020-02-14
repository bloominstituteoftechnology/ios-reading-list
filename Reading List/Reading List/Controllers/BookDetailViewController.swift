//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by David Williams on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var bookController: BookController?
    @IBOutlet weak var bookTitleLabel: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!
    
    var book: Book?
    var delegate: handleBookDelegate?
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        reasonToReadTextField.text = book.reasonToRead
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
  
    @IBAction func saveBookTapped(_ sender: UIButton) {
        guard let title = bookTitleLabel.text,
            let reason = reasonToReadTextField.text,
            !title.isEmpty,
            !reason.isEmpty else {return}
        if let book = book {
            bookController?.updateBook(book: book, title, reason: reason)
           // navigationController?.popViewController(animated: true)
        } else {
            bookController?.createBook(named: title, reasonToRead: reason, hasBeenRead: false)
            //navigationController?.popViewController(animated: true)
        }
        #warning("no need fot this line to be in both if lets if it the same destination")
        navigationController?.popViewController(animated: true)
    }
}
