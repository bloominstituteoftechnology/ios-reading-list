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
    @IBOutlet weak var reasonToReadLabel: UITextView!
    
    var book: Book?
    var delegate: handleBookDelegate?
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        reasonToReadLabel.text = book.reasonToRead
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveBookTapped(_ sender: UIButton) {
        guard let title = bookTitleLabel.text,
            let reason = reasonToReadLabel.text,
            !title.isEmpty,
            !reason.isEmpty else {return}
        if let book = book {
            delegate?.updateBook(book: book, title: title, reason: reason)
            navigationController?.popViewController(animated: true)
        } else {
            delegate?.createBook(title: title, reason: reason)
            dismiss(animated: true, completion: nil)
        }
    }
}
