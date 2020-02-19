//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jarren Campos on 2/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    
    
    func updateViews() {
        if book != nil {
            self.title = book?.title
            titleTextField.text = book?.title
            detailTextView.text = book?.reasonToRead
        }else{
            self.title = "Add a new book"
        }
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, let reason = detailTextView.text else { return }
        if let book = book{
            bookController?.updateTitleReason(book: book, title: title)
        }else{
            bookController?.createBook(named: title, withReason: reason, beenRead: false)
        }
        navigationController?.popViewController(animated: true)
    }
    
}


