//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Alex Thompson on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
      override func viewDidLoad() {
          super.viewDidLoad()

          // Do any additional setup after loading the view.
      }
    @IBOutlet weak var bookTextField: UITextField!
    
    @IBOutlet weak var bookTextView: UITextView!
    @IBAction func saveButtonTapped(_ sender: Any) {
    
        guard let title = bookTextField.text,
            let reasonToRead = bookTextView.text,
            title != "" && reasonToRead != "" else { return }
        
        if let book = book {
            bookController?.update(book: book, withTitle: title, reasonToRead: reasonToRead)
        } else {
            bookController?.createNewBook(title: title, reasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }
        private func updateViews() {
        guard let book = book else {
            title = "Add a new book"
            return }
        
        title = book.title
        bookTextField.text = book.title
        bookTextView.text = book.reasonToRead
    }
    
}
    
var book: Book?
var bookController: BookController?
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


