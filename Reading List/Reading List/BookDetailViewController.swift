//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by patelpra on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateViews()
    }
    
    // Step 4. BookDetailViewController
    func updateViews()  {
        if let book = self.book {
            self.titleTextField.text = book.title
            self.reasonToReadTextView.text = book.reasonToRead
            title = book.title
        } else {
            self.title = "Add a new book"
        }
    }
    // Step 5. BookDetailViewController
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = self.titleTextField.text,
            let reasonToRead = self.reasonToReadTextView.text else { return }
        if let book = self.book {
            self.bookController?.updateBook(for: book, withTitle: title, withReasonToRead: reasonToRead)
        } else {
            self.bookController?.createBook(withTitle: title, withReasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
}
