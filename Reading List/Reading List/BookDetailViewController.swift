//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Dawn Jones on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    @IBAction func saveTapped(_ sender: Any) {
        if let book = book {
            bookController?.updateBookData(for: book, title: book.title, reasonToRead: book.reasonToRead)
        } else {
            guard let title = titleTextField.text,
                let reason = reasonTextView.text else { return }
            bookController?.createBook(title: title, reasonToRead: reason)
        }
        navigationController?.popViewController(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if let book = book {
            titleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
            title = book.title
        } else {
            title = "Add a new book"
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
