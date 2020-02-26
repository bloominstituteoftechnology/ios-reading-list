//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Bradley Diroff on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol AddBookDelegate {
    func bookWasAdded(_ book: Book)
}

class BookDetailViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    
    @IBOutlet var reasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    var delegate: AddBookDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let newBook = book {
            bookController?.updateTitleOrReasson(with: newBook, title: newBook.title, reason: newBook.reasonToRead)
        } else {
            guard let title = titleField.text, let reason = reasonTextView.text else {return}
            let freshBook = Book(title: title, reasonToRead: reason)
            delegate?.bookWasAdded(freshBook)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        guard let book = book else {
            navigationItem.title = "Add a new book"
            return
        }
        
        navigationItem.title = book.title
        titleField.text = book.title
        reasonTextView.text = book.reasonToRead
    }
    

}
