//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Dillon P on 8/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol AddBookDelegate {
    func bookWasAdded()
}

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    var delegate: AddBookDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveTapped(sender: UIBarButtonItem) {
        guard let bookName = bookNameTextField.text,
            !bookName.isEmpty,
            let reason = reasonToReadTextView.text,
            !reason.isEmpty else { return }
        
        if book == nil {
            bookController?.createBook(named: bookName, forReason: reason, beenRead: false)
            delegate?.bookWasAdded()
        } else if book != nil {
            if let book = book {
                bookController?.editBook(book: book, with: bookName, reasonToRead: reason)
                delegate?.bookWasAdded()
            }
        }
        
    }
    
    func updateViews() {
        if let book = book {
            bookNameTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
            self.title = book.title
        } else {
            self.title = "Add a new book"
        }
        
    }

}
