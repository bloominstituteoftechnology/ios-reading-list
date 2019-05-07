//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jeremy Taylor on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let book = book, isViewLoaded else { return}
        
        title = book.title
        bookTitleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let tile = bookTitleTextField.text,
            let reasonToRead = reasonToReadTextView.text else { return }
        if book == nil {
            bookController?.createBook(withTitle: tile, reasonToRead: reasonToRead)
        } else {
            if let book = book {
                bookController?.updateBookInfo(for: book, withTitle: tile, andReasonToRead: reasonToRead)
            }
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
