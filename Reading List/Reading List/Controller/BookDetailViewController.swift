//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Shawn James on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!
    
    // MARK: - Properties
    var bookController: BookController?
    var book: Book?
    var readingListTableViewController = ReadingListTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let bookTitle = bookTitleTextField.text else { return }
        
        if let unwrappedBook = book {
            
            bookController?.updateText(book: unwrappedBook, title: bookTitle, reasonToRead: reasonToReadTextField.text)
        } else {
            bookController?.createBook(title: bookTitle, reasonToRead: reasonToReadTextField.text)
        }
        if let parent = navigationController?.viewControllers.first as? ReadingListTableViewController { parent.tableView.reloadData() }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    func updateViews() {
        if let book = book {
            bookTitleTextField.text = book.title
            reasonToReadTextField.text = book.reasonToRead
            self.title = book.title
        } else {
            self.title = "Add a new book"
        }
    }
    
}
