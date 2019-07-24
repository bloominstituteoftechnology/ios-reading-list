//
//  AddBookViewController.swift
//  Reading List
//
//  Created by brian vilchez on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        reasonToReadTextView.text = "Reason to Read:"
    }
    
    var book: Book?
    
    @IBOutlet weak var BookTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    @IBAction func SaveBookButton(_ sender: UIBarButtonItem) {
        guard let book = BookTextField.text,
            let description = reasonToReadTextView.text else {return}
        var bookInfo = Book(title: book, reasonToRead: description, hasbeenRead: false)
        
        
    }
    
}
