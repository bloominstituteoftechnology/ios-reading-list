//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Michael on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookTextField: UITextField!
    
    @IBOutlet weak var bookTextView: UITextView!
    
    var bookController: BookController?
    
    
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        

        // Do any additional setup after loading the view.
    }
    @IBAction func saveTapped(_ sender: Any) {
        
        if let unwrappedBook = book {
                bookController?.editBook(for: unwrappedBook)
            } else {
            if let title = bookTextField.text, let reason = bookTextView.text, !title.isEmpty, !reason.isEmpty {
                let book = Book(title: title, reasonToRead: reason)
                bookController?.create(for: book)
                }
            }
            navigationController?.popViewController(animated: true)
        }

        
//        if let unwrappedBook = book {
//            bookController?.updateHasBeenRead(for: unwrappedBook)
//        } else if book == nil {
//            if let unwrappedBook = book {
//                bookController?.create(for: unwrappedBook)
//            }
//
//        }
        
        
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func updateViews() {
        guard isViewLoaded else { return }
        
        guard let unwrappedTitle = book?.title, let unwrappedReasonToRead = book?.reasonToRead else { return }
        bookTextField.text = unwrappedTitle
        bookTextView.text = unwrappedReasonToRead
        if book == nil {
            navigationItem.title = "Add a new book"
        } else {
            navigationItem.title = unwrappedTitle
        }
        
    }
    
}
