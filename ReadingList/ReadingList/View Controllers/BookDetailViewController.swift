//
//  BookDetailViewController.swift
//  ReadingList
//
//  Created by Lambda_School_Loaner_259 on 2/25/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var reasonToReadTextView: UITextView!
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let book = book {
            bookController?.updateReasonToRead(for: book, newReasonToRead: reasonToReadTextView.text)
            self.navigationController?.popToRootViewController(animated: true)
        } else if let title = titleTextField.text,
            !title.isEmpty,
            let reason = reasonToReadTextView.text,
            !reason.isEmpty {
            bookController?.createBook(title: title, reasonToRead: reason)
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            return
        }
    }
    
    // MARK: - Properties
    var bookController: BookController?
    var book: Book?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if let book = book {
            titleTextField.text = book.title
            reasonToReadTextView.text = "\(book.reaasonToRead)"
            self.title = book.title
        } else {
            self.title = "Add a new book."
        }
    }
}
