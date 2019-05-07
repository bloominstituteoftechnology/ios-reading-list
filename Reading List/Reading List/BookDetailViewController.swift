//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jonathan Ferrer on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func updateViews() {
        guard let book = book else {
            self.navigationItem.title = "Add a new Book"
            return
        }
        bookTitleTextField.text = book.title
        reasontoReadTextView.text = book.reasonToRead
        self.navigationItem.title = book.title
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let book = book else {
            bookController?.createBook(title: bookTitleTextField.text!, reasonToRead: reasontoReadTextView.text, hasBeenRead: false)
            return
        }
        bookController?.updateBook(for: book, withTitle: bookTitleTextField.text!, reasonToRead: reasontoReadTextView.text)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasontoReadTextView: UITextView!
    
}
