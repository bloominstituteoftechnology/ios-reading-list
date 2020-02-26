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
    func bookWasUpdated(oldBook: Book, title: String, reason: String)
}

class BookDetailViewController: UIViewController {

    @IBOutlet var navigationTop: UINavigationItem!
    
    
    @IBOutlet var titleField: UITextField!
    
    @IBOutlet var reasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    var delegate: AddBookDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let newBook = book {
            guard let title = titleField.text, let reason = reasonTextView.text else {return}
            delegate?.bookWasUpdated(oldBook: newBook, title: title, reason: reason)
            navigationController?.popViewController(animated: true)
        } else {
            guard let title = titleField.text, let reason = reasonTextView.text else {return}
            let freshBook = Book(title: title, reasonToRead: reason)
            delegate?.bookWasAdded(freshBook)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        guard let book = book else {
            navigationTop.title = "Add a new book"
            return
        }
        
        navigationTop.title = book.title
        titleField?.text = book.title
        reasonTextView?.text = book.reasonToRead
    }
    

}
