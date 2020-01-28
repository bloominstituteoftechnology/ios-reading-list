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
        if book != nil {
            updateViews()
        } else {
            bookController?.createBook(title: textField.text ?? "", reason: textView.text ?? "")
        }
        navigationController?.popViewController(animated: true)
   
    }
    func updateViews() {
        if  book != nil {
            textView.text = book!.reasonToRead
            textField.text = book!.title
            navigationItem.title = book!.title
        } else {
            textField.text =  ""
            textView.text = "Reason to read:"
            navigationItem.title = "Add a new book"
        }
    }
    
}
