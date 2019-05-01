//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by morse on 4/29/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet var bookTitleTextField: UITextField!
    @IBOutlet var reasonToRead: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = bookTitleTextField.text else { return }
        guard let reasonToRead = reasonToRead.text else { return }
        
        if book == nil {
            bookController?.createBook(title: title, reasonToRead: reasonToRead)
            
        } else {
            guard let book = book else { return }
            bookController?.editBook(called: book, title: title, reasonToRead: reasonToRead)
            
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if book != nil {
            bookTitleTextField.text = book?.title
            reasonToRead.text = book?.reasonToRead
            title = book?.title
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
