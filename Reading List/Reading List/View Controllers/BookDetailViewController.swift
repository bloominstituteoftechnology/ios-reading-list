//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Ian Becker on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var reasonToRead: UITextView!
    @IBAction func saveBook(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func updateViews() {
        guard let book = book else { return }
        
        bookTitle.text = book.title
        reasonToRead.text = book.reasonToRead
    }
    
}
