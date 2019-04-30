//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jeffrey Carpenter on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let title = bookTitleTextField.text,
        !title.isEmpty,
        let reason = reasonTextView.text,
        !reason.isEmpty
        else { return }
        
        if let book = book {
            bookController?.updateBook(book, newTitle: title, newReason: reason)
        } else {
            bookController?.createBook(titled: title, withReason: reason)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        
        guard let book = book else { return }
        
        bookTitleTextField.text = book.title
        reasonTextView.text = book.reasonToRead
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
