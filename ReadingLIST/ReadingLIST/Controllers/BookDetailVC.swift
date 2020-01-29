//
//  BookDetailVC.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class BookDetailVC: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
       updateViews()
        
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        saveButton.isEnabled = textField.hasText
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let title = textField.text,
            let reasonToRead = textView.text,
            title != "" && reasonToRead != "" else { return }
        
        if let book = book {
            bookController?.editBook(for: book, with: title, with: reasonToRead)
        } else {
            bookController?.createBook(title: title, reason: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
   
    }
    
    
    func updateViews() {
        guard let book = book else {
            title = "Add a new book"
            return }
        
        title = book.title
        textField.text = book.title
        textView.text = book.reasonToRead
    }
    
    

}
