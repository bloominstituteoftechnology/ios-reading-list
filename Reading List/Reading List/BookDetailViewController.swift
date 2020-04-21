//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Vincent Hoang on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet var bookTitle: UITextField?
    @IBOutlet var reason: UITextView?
    @IBOutlet var saveButton: UIBarButtonItem?
    
    var book: Book? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        if let unwrappedBook = book  {
            bookTitle?.text = unwrappedBook.title
            reason?.text = unwrappedBook.reasonToRead
        }
    }
    
    override func viewDidLoad() {
        updateView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        if let unwrappedTitle = bookTitle?.text, let unwrappedReason = reason?.text {
            book = Book(unwrappedTitle, unwrappedReason)
        }
    }
}
