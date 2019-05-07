//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Ryan Murphy on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var bookController: BookController?
    var book: Book?
    @IBOutlet weak var reasonToReadView: UITextView!
    @IBOutlet weak var bookTitleField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let title = bookTitleField.text,
            !title.isEmpty,
            let reason = reasonToReadView.text,
            !reason.isEmpty
            else { return }
        
        if let book = book {
            bookController?.updateBook(book: book, newTitle: title, NewReason: reason)
        } else {
            bookController?.createBook(title: title, reasonToRead: reason)
        }
        
        navigationController?.popViewController(animated: true)
        //for debug
        //print("Button Was Pushed")
    }
    
    func updateViews() {
        
        if let book = book  {
            self.navigationItem.title = book.title
            bookTitleField.text = book.title
            reasonToReadView.text = book.reasonToRead
        } else { return }
        }
    }
    

