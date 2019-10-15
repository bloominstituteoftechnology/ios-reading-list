//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by morse on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let book = book {
            bookController?.updateReasonOrTitle(for: book)
        } else {
            guard let title = titleTextField.text, let reason = reasonTextView.text, !title.isEmpty, !reason.isEmpty else { return }
            bookController?.createBook(named: title, withReason: reason)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateView() {
        if let book = book {
            self.title = book.title
            titleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
        } else {
            reasonTextView.text = ""
            titleTextField.becomeFirstResponder()
            navigationItem.title = "Add a new book"
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
