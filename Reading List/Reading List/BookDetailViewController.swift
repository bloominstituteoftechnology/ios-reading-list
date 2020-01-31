//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Lambda_School_Losaner_256 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit



class BookDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let title = textTitleField.text,
            let reasonToRead = reasonToReadTextView.text,
            title != "" && reasonToRead != "" else { return }
        
        if let book = book {
            bookController?.update(book: book, withTitle: title, reasonToRead: reasonToRead)
        } else {
            bookController?.createBook(named: title, withReason: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    private func updateViews() {
        guard let book = book else {
            title = "Add a new book"
            return }
        
        title = book.title
        textTitleField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
    }
    
    
    var bookController: BookController?
    
    var book: Book?
    
    @IBOutlet weak var textTitleField: UITextField!
    
    @IBOutlet weak var reasonToReadTextView: UITextView!

}


