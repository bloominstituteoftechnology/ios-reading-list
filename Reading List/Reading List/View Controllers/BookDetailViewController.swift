//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Rob Vance on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
// Mark: IBOutlets
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    var bookController: BookController?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
// Mark: IBAction
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = bookTitleTextField.text,
              let reasonToRead = reasonToReadTextView.text,
            !title.isEmpty, !reasonToRead.isEmpty else { return }
        
        if let book = book {
            bookController?.update(book: book, with: title, and: reasonToRead)
        } else {
            bookController?.createBook(title: title, reasonToRead: reasonToRead)
        }
        if let parent = navigationController?.viewControllers.first as? ReadingListTableViewController {
            parent.tableView.reloadData()
        }
        navigationController? .popViewController(animated: true)
    }
    func updateViews() {
        guard let book = book else { return }
            bookTitleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
    }
    
}
