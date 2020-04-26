//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Josh Kocsis on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadViewText: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleTextField.text = book.title
        reasonToReadViewText.text = book.reasonToRead
        navigationItem.title = book.title
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let book = book {
        guard let title = bookTitleTextField.text,
           let reasons = reasonToReadViewText.text else { return }
        bookController?.update(for: book, title: title, reasonToRead: reasons)
        navigationController?.popViewController(animated: true)
        } else {
            guard let title = bookTitleTextField.text,
                let reasons = reasonToReadViewText.text else { return }
            bookController?.create(title: title, reasonToRead: reasons, hasBeenRead: false)
            navigationController?.popViewController(animated: true)
        }
    }
}
