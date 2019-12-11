//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by LaFleur on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit


class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookNameTextField: UITextField!
        
    @IBOutlet weak var reasonToReadTextField: UITextView!
    
    
//    var book: Book?
        
   
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
            guard let bookName = bookNameTextField.text,
                bookName != "",
                let reasonToRead = reasonToReadTextField.text,
                reasonToRead != "" else { return }
            
        let book = Book(title: bookName, reasonToRead: reasonToRead)
    }
}

