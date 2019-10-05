//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Joseph Rogers on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailTextField: UITextField!
    
    var bookController: BookController?
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let book = book else {return}
        detailTextField.text = book.title
        detailTextView.text = book.reasonToRead
        
        if book.title != "" {
            self.title = book.title
        } else {
            self.title = "Add a new book"
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if book == nil {
            bookController?.createBook(named: book!.title, withReasonToRead: book!.reasonToRead)
        } else {
            bookController?.updateBook(for: book!, newTitle: book?.title ?? "Error fetching name for book", newReason: book?.reasonToRead ?? "Error fetching a reason to read book.")
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
