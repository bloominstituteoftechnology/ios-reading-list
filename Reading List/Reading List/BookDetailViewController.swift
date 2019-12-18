//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Aaron Cleveland on 12/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: Variables
    var book: Book?
    var bookController: BookController?
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    //MARK: IBActions
    @IBAction func saveButton(_ sender: Any) {
        if let book = book {
            guard let title = textField.text,
                let reasonText = textView.text else { return }
            bookController?.updateBookInformation(book: book, title: title, reasonToRead: reasonText)
            self.dismiss(animated: true, completion: nil)
        } else {
            guard let title = textField.text,
                let reasonText = textView.text else { return }
            bookController?.createBook(title: title, reasonToRead: reasonText)
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: Helper Functions
    func updateViews() {
        guard let book = book else { return }
        self.textField.text = book.title
        self.textView.text = book.reasonToRead
    }
}
