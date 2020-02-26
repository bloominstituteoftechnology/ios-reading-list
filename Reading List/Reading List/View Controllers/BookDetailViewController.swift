//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Harmony Radley on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
 

    @IBAction func saveButton(_ sender: Any) {
        
    }
    
    
    


    func updateViews() {
        bookTitleTextField.text = book?.title
        reasonToReadTextView.text = book?.reasonToRead
        guard let book = book else {
            navigationItem.title = "Add a new book"
            return
        }
        
        
    }
    
  

}

