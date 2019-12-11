//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Osha Washington on 12/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?


    // MARK: - IBOutlets
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    // MARK: - IBAction
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    guard let title = bookTitleTextField.text,
    let reasonToRead = reasonToReadTextView.text,
    !title.isEmpty,
    !reasonToRead.isEmpty else { return }
    
    // MARK: - New Book
    bookController?.createBook(title: title, reasonToRead: reasonToRead)
    navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateViews() {
        guard let book = book else {
        title = "Add a new Book"
        return }

        title = book.title
        bookTitleTextField.text = book.title
        reasonToReadTextView.text = "\(book.reasonToRead)"
    }

}

