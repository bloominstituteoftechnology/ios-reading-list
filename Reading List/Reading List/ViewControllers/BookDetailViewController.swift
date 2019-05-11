//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Seschwan on 5/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTextField: UITextField!
    @IBOutlet weak var bookTextView:  UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if let book = book {
            bookTextField.text = book.title
            bookTextView.text = book.reasonToRead
            navigationItem.title = book.title
        } else {
            navigationItem.title = "Add A New Book"
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        guard let title = bookTextView.text,
            let reasonToRead = bookTextView.text
            else {
                return
        }
        if book == nil {
            bookController?.addBookToList(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
            navigationController?.popViewController(animated: true)
        } else if let book = book {
            bookController?.updateHasBeenRead(for: book)
            navigationController?.popViewController(animated: true)
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
