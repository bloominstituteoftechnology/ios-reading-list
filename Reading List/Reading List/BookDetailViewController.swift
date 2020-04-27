//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Bronson Mullens on 4/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add a book"
    }
    
    // IBOutlets
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonsToReadTextView: UITextView!
    
    
    // IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = bookTitleTextField.text,
            let reasonToRead = reasonsToReadTextView.text,
            !title.isEmpty,
            !reasonToRead.isEmpty else { return }
        
        if let book = book {
            bookController?.updateBookInfo(for: book, newTitle: title, newReasonToRead: reasonToRead)
        } else {
            bookController?.createBook(bookTitle: title, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }

    var bookController: BookController?
    
    var book: Book?
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleTextField.text = book.title
        reasonsToReadTextView.text = book.reasonToRead
        title = book.title
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
