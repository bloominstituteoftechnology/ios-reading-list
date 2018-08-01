//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Conner on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let book = book else { return }
        bookTitle.text = book.title
        bookReasonToReadText.text = book.reasonToRead
    }

    
    @IBAction func saveBookUpdate(_ sender: Any) {
        if (book == nil) {
            guard let bookTitle = bookTitle.text,
                let reasonToRead = bookReasonToReadText.text else { return }
            bookController?.createBook(title: bookTitle, reasonToRead: reasonToRead, hasBeenRead: false)
        } else {
            guard let book = book,
                let bookTitle = bookTitle.text,
                let reasonToRead = bookReasonToReadText.text else { return }
            bookController?.updateBookTitle(for: book, title: bookTitle)
            bookController?.updateReasonToRead(for: book, reasonToRead: reasonToRead)
            bookController?.saveToPersistentStore()
        }
    }
    
    @IBOutlet var bookTitle: UITextField!
    @IBOutlet var bookReasonToReadText: UITextView!
    
    var bookController: BookController?
    var book: Book?
}
