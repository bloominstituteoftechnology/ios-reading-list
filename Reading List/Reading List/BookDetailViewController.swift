//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Aaron Peterson on 4/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextField!
    
    var bookController: BookController?
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func save(_ sender: Any) {
        if book == nil {
            guard let title = bookTitleTextField.text, let reason = reasonToReadTextField.text else { return }
            bookController?.createBook(with: title, reasonToRead: reason, hasBeenRead: false)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        bookTitleTextField.text = book?.title
        reasonToReadTextField.text = book?.reasonToRead
        
        if book == nil {
            navigationController?.title = "Add a new book"
        } else {
            navigationController?.title = "Edit book details"
        }
    }
    
}
