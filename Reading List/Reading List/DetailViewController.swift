//
//  DetailViewController.swift
//  Reading List
//
//  Created by Matthew Martindale on 2/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var delegate: BookTableViewCellDelegate?
    var bookController: BookController?
    
    var book: Book?{
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add a new book"
        updateViews()
    }
    
    @IBAction func saveBookButtonTapped(_ sender: Any) {
        guard let bookController = bookController else { return }
        guard let title = titleTextField.text, !title.isEmpty,
            let reasonToRead = reasonToReadTextView.text, !reasonToRead.isEmpty else { return }
        
        if let book = book {
            bookController.updateTitleAndReasonToRead(for: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController.createBook(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        loadViewIfNeeded()
        guard let book = book else { return }
        titleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
        title = book.title
    }
}

//use sf symbols checkmark on cell
//set configuration on symbol with point size and weight
