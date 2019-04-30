//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Victor  on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class BookDetailViewController: UIViewController {
    //properties
    @IBOutlet weak var bookTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    //passing data
    var bookController: BookController?
    var book: Book?
    
    //handling data when view appears
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let book = book else {return}
        bookTextField.text = book.title
        textView.text = book.reasonToRead
    }
    
    

    @IBAction func saveButtonPressed(_ sender: Any) {
        //handle when save button is pressed
        //handles logic for new or updated book
        if book == nil {
            //logic to handle save button pressed
            guard let title = bookTextField.text, let reasonToRead = textView.text else {
                //error handling
                let alert = UIAlertController(title: "No Book", message: "Please enter title and reason for book", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return}
            if reasonToRead == "" {
                //error handling
                let alert = UIAlertController(title: "No Book", message: "Please enter reason for book", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            if title == "" {
                //error handling
                let alert = UIAlertController(title: "No Book", message: "Please enter title for book", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            //creates book when no errors
            bookController?.addBook(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        } else {
            //updates book
            guard let book = book, let title = bookTextField.text, let reasonToRead = textView.text else {return}
            if title == "" {
                return
            }
            if reasonToRead == "" {
                return
            }
            //updates book
            bookController?.updateBookDetails(for: book, reasonToRead: reasonToRead, title: title)
            bookController?.saveToPersistenceStore()
        }
        
        //navigation back
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
    
}
