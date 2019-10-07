//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Christy Hicks on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
  
    var bookController = BookController()
    var book: Book?
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    
    @IBOutlet weak var bookReasonsTextView: UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard book != nil else {
            let title = bookTitleTextField.text ?? ""
            let reason = bookReasonsTextView.text ?? ""
            bookController.create(book: Book(title: title, reasonToRead: reason))
            navigationController?.popToRootViewController(animated: true)
            return
        }
        let title = bookTitleTextField.text
        let reason = bookReasonsTextView.text
        bookController.updateBookText(for: book!, newTitle: title, newReason: reason)
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    func updateViews() {
        guard let book = book else {
            self.navigationItem.title = "Add a book"
            return
        }
            bookTitleTextField.text = book.title
            bookReasonsTextView.text = book.reasonToRead
            self.navigationItem.title = book.title
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


