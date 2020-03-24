//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Harmony Radley on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var book: Book?
    var bookController: BookController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text,
                   let reasonToRead = reasonToReadTextView.text,
                   title != "" && reasonToRead != "" else { return }
               
               if let book = book {
                   bookController?.update(book: book, withTitle: title, reasonToRead: reasonToRead)
               } else {
                   bookController?.createBook(withTitle: title, reasonToRead: reasonToRead)
               }
               
               navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let book = book else {
            title = "Add a new book"
            return }
        
        title = book.title
        titleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
    }
}
